<?php
class gestion_escuela_ci extends toba_ci
{
	/**
	 * Prepara el cuerpo HTML de un mail: pasa los caracteres con acento a
	 * entidades HTML, asi se ven bien sin depender de la codificacion.
	 */
	protected function texto_mail($html)
	{
		if (!function_exists('mb_encode_numericentity')) {
			return $html;
		}
		if (!mb_check_encoding($html, 'UTF-8')) {
			$html = mb_convert_encoding($html, 'UTF-8', 'ISO-8859-1');
		}
		return mb_encode_numericentity($html, array(0x80, 0x10FFFF, 0, 0x1FFFFF), 'UTF-8');
	}
}
?>