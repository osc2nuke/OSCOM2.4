<?php
	/*
		$Id$
		
		osCommerce, Open Source E-Commerce Solutions
		http://www.oscommerce.com
		
		Copyright (c) 2015 osCommerce
		
		Released under the GNU General Public License
	*/
	
	use OSC\OM\Registry;
	
	class cm_cs_thank_you {
		var $code;
		var $group;
		var $title;
		var $description;
		var $sort_order;
		var $enabled = false;
		
		function cm_cs_thank_you() {
			global $osC_Language;
			$this->code = get_class($this);
			$this->group = basename(dirname(__FILE__));
			
			$this->title = $osC_Language->get('MODULE_CONTENT_CHECKOUT_SUCCESS_THANK_YOU_TITLE');
			$this->description = $osC_Language->get('MODULE_CONTENT_CHECKOUT_SUCCESS_THANK_YOU_DESCRIPTION');
			
			if ( defined('MODULE_CONTENT_CHECKOUT_SUCCESS_THANK_YOU_STATUS') ) {
				$this->sort_order = MODULE_CONTENT_CHECKOUT_SUCCESS_THANK_YOU_SORT_ORDER;
				$this->enabled = (MODULE_CONTENT_CHECKOUT_SUCCESS_THANK_YOU_STATUS == 'True');
			}
		}
		
		function execute() {
			global $osC_Language, $oscTemplate;
			
			ob_start();
			include(DIR_WS_MODULES . 'content/' . $this->group . '/templates/thank_you.php');
			$template = ob_get_clean();
			
			$oscTemplate->addContent($template, $this->group);
		}
		
		function isEnabled() {
			return $this->enabled;
		}
		
		function check() {
			return defined('MODULE_CONTENT_CHECKOUT_SUCCESS_THANK_YOU_STATUS');
		}
		
		function install() {
			$OSCOM_Db = Registry::get('Db');
			
			$OSCOM_Db->save('configuration', [
			'configuration_title' => 'Enable Thank You Module',
			'configuration_key' => 'MODULE_CONTENT_CHECKOUT_SUCCESS_THANK_YOU_STATUS',
			'configuration_value' => 'True',
			'configuration_description' => 'Should the thank you block be shown on the checkout success page?',
			'configuration_group_id' => '6',
			'sort_order' => '1',
			'set_function' => 'tep_cfg_select_option(array(\'True\', \'False\'), ',
			'date_added' => 'now()'
			]);
			
			$OSCOM_Db->save('configuration', [
			'configuration_title' => 'Sort Order',
			'configuration_key' => 'MODULE_CONTENT_CHECKOUT_SUCCESS_THANK_YOU_SORT_ORDER',
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
			return array('MODULE_CONTENT_CHECKOUT_SUCCESS_THANK_YOU_STATUS', 'MODULE_CONTENT_CHECKOUT_SUCCESS_THANK_YOU_SORT_ORDER');
		}
	}

