<?php
class ci_pasar_historico extends gestion_escuela_ci
{
	//-----------------------------------------------------------------------------------
	//---- Configuraciones --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	/**
	 * Ventana que se ejecuta al inicio de la etapa de configuraci�n. Antes de la configuraci�n de la pantalla y sus componentes
	 * Se utiliza por ejemplo para determinar qu� pantalla mostrar, eliminar tabs, etc.
	 */
	function conf()
	{
	}

	//-----------------------------------------------------------------------------------
	//---- Eventos ----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	/**
	 * Atrapa la interacci�n del usuario a trav�s del bot�n asociado. El m�todo no recibe par�metros
	 */
	function evt__phistorico()
	{


		try{	
			//Insertar datos en his_cabecera
			$id_cabecera = toba::consulta_php('gestion_escuela')->his_reg_cabecera();

			//Insertar datos en his_detalle
			$datos = toba::consulta_php('gestion_escuela')->his_reg_detalle($id_cabecera);
			
		}catch (toba_error_db $e){

			toba::notificacion()->agregar('ATENCION!! El registro ya Existe.');

		}

	}

	//-----------------------------------------------------------------------------------
	//---- cuadro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	/**
	 * Permite cambiar la configuraci�n del cuadro previo a la generaci�n de la salida
	 * El formato de carga es de tipo recordset: array( array('columna' => valor, ...), ...)
	 */
	function conf__cuadro(toba_ei_cuadro $cuadro)
	{
				//if(isset($this->s__filtro)){
                //$where = $this->dep('filtro')->get_sql_where();	
                $datos = toba::consulta_php('gestion_escuela')->get_inscripciones();
				$cuadro->set_datos($datos); 
             

	}

}

?>