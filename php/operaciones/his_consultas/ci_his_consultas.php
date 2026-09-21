<?php
class ci_his_consultas extends gestion_escuela_ci
{
	protected $s__filtro;
	protected $s__id_cabecera;
	
	
	//-----------------------------------------------------------------------------------
	//---- Configuraciones --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	/**
	 * Ventana de extensi�n para configurar la pantalla. Se ejecuta previo a la configuraci�n de los componentes pertenecientes a la pantalla 
	 * por lo que es ideal por ejemplo para ocultarlos en base a una condici�n din�mica, ej. $pant->eliminar_dep("tal") 
	 * @param toba_ei_pantalla $pantalla
	 */
	function conf__pant_inicial(toba_ei_pantalla $pantalla)
	{
		$hay_cambios = $this->dep('datos')->hay_cambios();
            toba::menu()->set_modo_confirmacion('Esta a punto de abandonar la edición del alumno sin grabar, ¿Desea continuar?', $hay_cambios);
	}
	

	/**
	 * Ventana de extensi�n para configurar la pantalla. Se ejecuta previo a la configuraci�n de los componentes pertenecientes a la pantalla 
	 * por lo que es ideal por ejemplo para ocultarlos en base a una condici�n din�mica, ej. $pant->eliminar_dep("tal") 
	 * @param toba_ei_pantalla $pantalla
	 */
	function conf__pant_edicion(toba_ei_pantalla $pantalla)
	{
	}

	function evt__restaurar()
	{
        if (
                !isset($this->s__id_cabecera) ||
                (int) $this->s__id_cabecera <= 0
        ) {
                toba::notificacion()->agregar(
                        'No se pudo identificar el periodo seleccionado.',
                        'error'
                );
                return;
        }

        try {
                toba::db()->abrir_transaccion();

                $cantidad = toba::consulta_php('gestion_escuela')
                        ->restaurar_inscripciones($this->s__id_cabecera);

                if ($cantidad === 0) {
                        toba::db()->rollback();

                        toba::notificacion()->agregar(
                                'El periodo seleccionado no contiene inscripciones.',
                                'error'
                        );
                        return;
                }

                toba::db()->cerrar_transaccion();

                toba::notificacion()->agregar(
                        "Se restauraron $cantidad inscripciones correctamente.",
                        'info'
                );

                $this->dep('datos')->resetear();
                unset($this->s__id_cabecera);
                $this->set_pantalla('pant_inicial');

        } catch (toba_error_db $e) {
                toba::db()->rollback();

                toba::notificacion()->agregar(
                        'No se pudo restaurar el periodo. Las inscripciones actuales no fueron modificadas.',
                        'error'
                );
        }
	}



	//-----------------------------------------------------------------------------------
	//---- cuadro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	/**
	 * Permite cambiar la configuraci�n del cuadro previo a la generaci�n de la salida
	 * El formato de carga es de tipo recordset: array( array('columna' => valor, ...), ...)
	 */
	function conf__cuadro(gestion_escuela_ei_cuadro $cuadro)
	{
			$where = isset($this->s__filtro) ? $this->dep('filtro')->get_sql_where() : '1=1';
        	$datos = toba::consulta_php('gestion_escuela')->get_his_cabecera($where);
        	$cuadro->set_datos($datos);
	}

	/**
	 * Atrapa la interacci�n del usuario con el bot�n asociado
	 * @param array $seleccion Id. de la fila seleccionada
	 */
	function evt__cuadro__seleccion($seleccion)
	{
		if (!isset($seleccion['id'])) {
        toba::notificacion()->agregar(
                'No se pudo identificar el periodo seleccionado.','error');
        return;
		}
		$this->s__id_cabecera = (int) $seleccion['id'];
		$this->dep('datos')->cargar($seleccion);
        $this->set_pantalla('pant_edicion'); 
	}

	//-----------------------------------------------------------------------------------
	//---- cuadro_con -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	/**
	 * Permite cambiar la configuraci�n del cuadro previo a la generaci�n de la salida
	 * El formato de carga es de tipo recordset: array( array('columna' => valor, ...), ...)
	 */
	function conf__cuadro_con(gestion_escuela_ei_cuadro $cuadro)
	{
		if(!isset($this->s__id_cabecera)){
			$cuadro ->set_datos(array());
			return;
		}

		$where = 'hi.id_his_cabecera = '.(int) $this->s__id_cabecera;

		$datos = toba::consulta_php('gestion_escuela')->get_his_inscripciones($where);

		$cuadro->set_datos($datos);	
	}


	//-----------------------------------------------------------------------------------
	//---- filtro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	/**
	 * Permite cambiar la configuraci�n del formulario previo a la generaci�n de la salida
	 * El formato del carga debe ser array(<campo> => <valor>, ...)
	 */
	function conf__filtro(gestion_escuela_ei_filtro $filtro)
	{
		if (isset($this->s__filtro)) {
                $filtro->set_datos($this->s__filtro);
            }  
	}
		
	

	/**
	 * Atrapa la interacci�n del usuario con el bot�n asociado
	 * @param array $datos Estado del componente al momento de ejecutar el evento. El formato es el mismo que en la carga de la configuraci�n
	 */
	function evt__filtro__filtrar($datos)
	{
		$this->s__filtro = $datos; 
	}

	/**
	 * Atrapa la interacci�n del usuario con el bot�n asociado
	 */
	function evt__filtro__cancelar()
	{
		unset($this->s__filtro); 
	}
	
}
?>