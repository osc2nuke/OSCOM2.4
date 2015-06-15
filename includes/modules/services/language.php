<?php
	/*
		$Id$
		
		osCommerce, Open Source E-Commerce Solutions
		http://www.oscommerce.com
		
		Copyright (c) 2007 osCommerce
		
		This program is free software; you can redistribute it and/or modify
		it under the terms of the GNU General Public License v2 (1991)
		as published by the Free Software Foundation.
	*/
	
	class osC_Services_language {
		function start() {
			global $osC_Language, $osC_Session;
			
			require('includes/classes/language_v3.php');
			$osC_Language = new osC_Language();
			
			if (isset($_GET['language']) && !empty($_GET['language'])) {
				$osC_Language->set($_GET['language']);
			}
			
			$osC_Language->load('general');
			$osC_Language->load('modules-action-recorder');
			$osC_Language->load('modules-boxes');
			$osC_Language->load('modules-content');
			$osC_Language->load('modules-header-tags');
			$osC_Language->load('modules-order-total');
			$osC_Language->load('modules-payment');
			$osC_Language->load('modules-shipping');
			$osC_Language->load('modules-social-bookmarks');
			
			header('Content-Type: text/html; charset=' . $osC_Language->getCharacterSet());
			
			osc_setlocale(LC_TIME, explode(',', $osC_Language->getLocale()));
			
			return true;
		}
		
		function stop() {
			return true;
		}
	}
?>
