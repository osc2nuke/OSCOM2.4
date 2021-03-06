<?php
	/*
		$Id$
		
		osCommerce, Open Source E-Commerce Solutions
		http://www.oscommerce.com
		
		Copyright (c) 2015 osCommerce
		
		Released under the GNU General Public License
	*/
	
	use OSC\OM\OSCOM;
	use OSC\OM\Registry;
	
	class sb_email {
		var $code = 'sb_email';
		var $title;
		var $description;
		var $sort_order;
		var $icon = 'email.png';
		var $enabled = false;
		
		function sb_email() {
			global $osC_Language;
			$this->title = $osC_Language->get('MODULE_SOCIAL_BOOKMARKS_EMAIL_TITLE');
			$this->public_title = $osC_Language->get('MODULE_SOCIAL_BOOKMARKS_EMAIL_PUBLIC_TITLE');
			$this->description = $osC_Language->get('MODULE_SOCIAL_BOOKMARKS_EMAIL_DESCRIPTION');
			
			if ( defined('MODULE_SOCIAL_BOOKMARKS_EMAIL_STATUS') ) {
				$this->sort_order = MODULE_SOCIAL_BOOKMARKS_EMAIL_SORT_ORDER;
				$this->enabled = (MODULE_SOCIAL_BOOKMARKS_EMAIL_STATUS == 'True');
			}
		}
		
		function getOutput() {
			return '<a href="' . OSCOM::link('tell_a_friend.php', 'products_id=' . $_GET['products_id']) . '"><img src="' . DIR_WS_IMAGES . 'social_bookmarks/' . $this->icon . '" border="0" title="' . tep_output_string_protected($this->public_title) . '" alt="' . tep_output_string_protected($this->public_title) . '" /></a>';
		}
		
		function isEnabled() {
			return $this->enabled;
		}
		
		function getIcon() {
			return $this->icon;
		}
		
		function getPublicTitle() {
			return $this->public_title;
		}
		
		function check() {
			return defined('MODULE_SOCIAL_BOOKMARKS_EMAIL_STATUS');
		}
		
		function install() {
			$OSCOM_Db = Registry::get('Db');
			
			$OSCOM_Db->save('configuration', [
			'configuration_title' => 'Enable E-Mail Module',
			'configuration_key' => 'MODULE_SOCIAL_BOOKMARKS_EMAIL_STATUS',
			'configuration_value' => 'True',
			'configuration_description' => 'Do you want to allow products to be shared through e-mail?',
			'configuration_group_id' => '6',
			'sort_order' => '1',
			'set_function' => 'tep_cfg_select_option(array(\'True\', \'False\'), ',
			'date_added' => 'now()'
			]);
			
			$OSCOM_Db->save('configuration', [
			'configuration_title' => 'Sort Order',
			'configuration_key' => 'MODULE_SOCIAL_BOOKMARKS_EMAIL_SORT_ORDER',
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
			return array('MODULE_SOCIAL_BOOKMARKS_EMAIL_STATUS', 'MODULE_SOCIAL_BOOKMARKS_EMAIL_SORT_ORDER');
		}
	}

