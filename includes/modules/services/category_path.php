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
	
	class osC_Services_category_path {
		function start() {
			global $osC_CategoryTree;
			
			osC_Services_category_path::process();
			
			include('modules/oscommerce/includes/classes/category_tree.php');
			$osC_CategoryTree = new osC_CategoryTree();
			
			return true;
		}
		
		function process($id = null) {
			global $cPath, $cPath_array, $current_category_id, $osC_CategoryTree;
			
			$cPath = '';
			$cPath_array = array();
			$current_category_id = 0;
			
			if (isset($_GET['cPath'])) {
				$cPath = $_GET['cPath'];
				} elseif (!empty($id)) {
				$cPath = $osC_CategoryTree->buildBreadcrumb($id);
			}
			
			if (!empty($cPath)) {
				$cPath_array = array_unique(array_filter(explode('_', $cPath), 'is_numeric'));
				$cPath = implode('_', $cPath_array);
				$current_category_id = end($cPath_array);
			}
		}
		
		function stop() {
			return true;
		}
	}
?>
