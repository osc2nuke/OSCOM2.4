<?php
	/*
		$Id$
		
		osCommerce, Open Source E-Commerce Solutions
		http://www.oscommerce.com
		
		Copyright (c) 2015 osCommerce
		
		Released under the GNU General Public License
	*/
	
	use OSC\OM\Registry;
	
	class bm_product_social_bookmarks {
		var $code = 'bm_product_social_bookmarks';
		var $group = 'boxes';
		var $title;
		var $description;
		var $sort_order;
		var $enabled = false;
		
		function bm_product_social_bookmarks() {
			global $osC_Language;
			$this->title = $osC_Language->get('MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_TITLE');
			$this->description = $osC_Language->get('MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_DESCRIPTION');
			
			if ( defined('MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_STATUS') ) {
				$this->sort_order = MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_SORT_ORDER;
				$this->enabled = (MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_STATUS == 'True');
				
				$this->group = ((MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_CONTENT_PLACEMENT == 'Left Column') ? 'boxes_column_left' : 'boxes_column_right');
			}
		}
		
		function execute() {
			global $osC_Language, $oscTemplate;
			
			if ( isset($_GET['products_id']) && defined('MODULE_SOCIAL_BOOKMARKS_INSTALLED') && tep_not_null(MODULE_SOCIAL_BOOKMARKS_INSTALLED) ) {
				$sbm_array = explode(';', MODULE_SOCIAL_BOOKMARKS_INSTALLED);
				
				$social_bookmarks = array();
				
				foreach ( $sbm_array as $sbm ) {
					$class = basename($sbm, '.php');
					
					if ( !class_exists($class) ) {
						include('includes/modules/social_bookmarks/' . $class . '.php');
					}
					
					$sb = new $class();
					
					if ( $sb->isEnabled() ) {
						$social_bookmarks[] = $sb->getOutput();
					}
				}
				
				if ( !empty($social_bookmarks) ) {
					ob_start();
					include('includes/modules/boxes/templates/product_social_bookmarks.php');
					$data = ob_get_clean();
					
					$oscTemplate->addBlock($data, $this->group);
				}
			}
		}
		
		function isEnabled() {
			return $this->enabled;
		}
		
		function check() {
			return defined('MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_STATUS');
		}
		
		function install() {
			$OSCOM_Db = Registry::get('Db');
			
			$OSCOM_Db->save('configuration', [
			'configuration_title' => 'Enable Product Social Bookmarks Module',
			'configuration_key' => 'MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_STATUS',
			'configuration_value' => 'True',
			'configuration_description' => 'Do you want to add the module to your shop?',
			'configuration_group_id' => '6',
			'sort_order' => '1',
			'set_function' => 'tep_cfg_select_option(array(\'True\', \'False\'), ',
			'date_added' => 'now()'
			]);
			
			$OSCOM_Db->save('configuration', [
			'configuration_title' => 'Content Placement',
			'configuration_key' => 'MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_CONTENT_PLACEMENT',
			'configuration_value' => 'Right Column',
			'configuration_description' => 'Should the module be loaded in the left or right column?',
			'configuration_group_id' => '6',
			'sort_order' => '1', 
			'set_function' => 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ',
			'date_added' => 'now()'
			]);
			
			$OSCOM_Db->save('configuration', [
			'configuration_title' => 'Sort Order',
			'configuration_key' => 'MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_SORT_ORDER',
			'configuration_value' => '0',
			'configuration_description' => 'Sort order of display. Lowest is displayed first.',
			'configuration_group_id' => '6',
			'sort_order' => '0',
			'date_added' => 'now()'
			]);
		}
		
		function remove() {
			return Registry::get('Db')->query('delete from :table_configuration where configuration_key in ("' . implode('", "', $this->keys()) . '")')->rowCount();
		}
		
		function keys() {
			return array('MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_STATUS', 'MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_CONTENT_PLACEMENT', 'MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_SORT_ORDER');
		}
	}
	
