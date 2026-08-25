<?php
class ci_notProfesores extends gestion_escuela_ci
{
    protected $s__filtro;
	protected $s__profesores;
	//-----------------------------------------------------------------------------------
	//---- Configuraciones --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__pant_inicial(toba_ei_pantalla $pantalla)
	{
	}

	//-----------------------------------------------------------------------------------
	//---- cuadro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cuadro(gestion_escuela_ei_cuadro $cuadro)
	{
			if(isset($this->s__filtro)){
                $where = $this->dep('filtro')->get_sql_where();	
                $datos = toba::consulta_php('gestion_escuela')->get_profesoresconsulta($where);

				$this-> s__profesores = $datos;

				$cuadro->set_datos($datos); 
            }  
	}

	//-----------------------------------------------------------------------------------
	//---- filtro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__filtro(gestion_escuela_ei_filtro $filtro)
	{
			if (isset($this->s__filtro)) {
                $filtro->set_datos($this->s__filtro);
            } 
	}

	function evt__filtro__filtrar($datos)
	{
		$this->s__filtro = $datos;  
	}

	function evt__filtro__cancelar()
	{
		unset($this->s__filtro);
		unset($this->s__profesores);
	}

	/**
	 * Atrapa la interacci�n del usuario con el bot�n asociado
	 * @param array $seleccion Id. de la fila seleccionada
	 */
	function evt__cuadro__mailindividual($seleccion)
	{
		$id_profesor = $seleccion['id_inscripcion'];

		$datos = toba::consulta_php('gestion_escuela')
						->get_alumnos_profesor($id_profesor);

		if (empty($datos)) {
			toba::notificacion()->agregar(
				'No existen alumnos inscriptos para las materias del profesor.',
				'error'
			);
			return;
		}

		$this->procesar_envio_profesor(
			array($datos[0]),
			$datos
		);
	}


	function procesar_envio_profesor($profesor, $alumnos, $notificar = true)
	{
		$nombre_profesor = $profesor[0]['nombre_completo'];
		$email = trim($profesor[0]['email']);
		$materia = $profesor[0]['descmateria'];
		$carrera = $profesor[0]['desccarrera'];

		if ($email == '') {
			if ($notificar) {
				toba::notificacion()->agregar('El profesor no tiene email cargado.', 'error');
			}
			return false;
		}

		$asunto = "Listado de alumnos inscriptos - $materia";

		$cuerpo = "
		<div style='font-family: Arial, Helvetica, sans-serif; font-size:14px'>
			<p>Estimado/a <b>$nombre_profesor</b>:</p>
			<p>Se informa el listado de alumnos inscriptos a la mesa de examen.</p>
			<p>
				<b>Carrera:</b> $carrera<br>
				<b>Materia:</b> $materia
			</p>
			<table border='1' cellpadding='5' cellspacing='0' width='100%'>
				<tr style='background:#f2f2f2'>
					<th>Legajo</th>
					<th>Apellido y Nombre</th>
					<th>DNI</th>
					<th>Email</th>
					<th>Fecha de inscripción</th>
				</tr>";
				foreach ($alumnos as $alumno) {

			$cuerpo .= "
			<tr>
				<td>{$alumno['legajo']}</td>
				<td>{$alumno['apellido']}, {$alumno['nombre']}</td>
				<td>{$alumno['dni']}</td>
				<td>{$alumno['email_alumno']}</td>
				<td>{$alumno['fecha_inscripcion']}</td>
			</tr>";
		}

		$cuerpo .= "
			</table>
			<br><hr>
			<small>
				Gestión Escuela<br>
				Mensaje generado automáticamente por el sistema.
			</small>
		</div>";

		try {

			$mail = new toba_mail($email, $asunto, $cuerpo);
			$mail->set_configuracion_smtp('gestion_escuela_smtp');
			$mail->set_html(true);
			$mail->enviar();

			if ($notificar) {
				toba::notificacion()->agregar('Correo enviado correctamente.', 'info');
			}

			return true;

		} catch (Exception $e) {

			toba::logger()->error($e->getMessage());

			if ($notificar) {
				toba::notificacion()->agregar('Error al enviar el correo.', 'error');
			}

			return false;
		}

	}			
	//-----------------------------------------------------------------------------------
	//---- Eventos ----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__mailmasivo()
	{
		if (empty($this->s__profesores)) {

			toba::notificacion()->agregar(
				'No hay profesores para enviar correo.',
				'error'
			);

			return;
		}

		$enviados = 0;
		$fallidos = 0;
		$sin_alumnos = 0;

		foreach ($this->s__profesores as $profesor) {

			try {

				// En get_profesoresconsulta():
				// pro.id AS id_inscripcion
				$id_profesor = $profesor['id_inscripcion'];

				$alumnos = toba::consulta_php('gestion_escuela')
							->get_alumnos_profesor($id_profesor);

				if (empty($alumnos)) {
					$sin_alumnos++;
					continue;
				}

				$ok = $this->procesar_envio_profesor(
					array($profesor),
					$alumnos,
					false
				);

				if ($ok) {
					$enviados++;
				} else {
					$fallidos++;
				}

			} catch (Exception $e) {

				toba::logger()->error($e->getMessage());
				$fallidos++;
			}
		}

		$mensaje = "Envío masivo finalizado: "
				. "$enviados enviados, "
				. "$fallidos con error";

		if ($sin_alumnos > 0) {
			$mensaje .= ", $sin_alumnos sin alumnos inscriptos";
		}

		toba::notificacion()->agregar(
			$mensaje,
			($fallidos == 0 && $sin_alumnos == 0)
				? 'info'
				: 'advertencia'
		);
	}
}
?>