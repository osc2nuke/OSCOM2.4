<?php
	/*
		$Id$
		
		osCommerce, Open Source E-Commerce Solutions
		http://www.oscommerce.com
		
		Copyright (c) 2009 osCommerce
		
		This program is free software; you can redistribute it and/or modify
		it under the terms of the GNU General Public License v2 (1991)
		as published by the Free Software Foundation.
	*/
	
	require('../includes/classes/language_v3.php');
	
	class osC_Language_Admin extends osC_Language {
		
		/* Public methods */
		public function loadIniFile($filename = null, $comment = '#', $language_code = null) {
			if ( is_null($language_code) ) {
				$language_code = $this->_code;
			}
			
			if ( $this->_languages[$language_code]['parent_id'] > 0 ) {
				$this->loadIniFile($filename, $comment, $this->getCodeFromID($this->_languages[$language_code]['parent_id']));
			}
			
			if ( is_null($filename) ) {
				if ( file_exists('..includes/languages/' . $language_code . '.php') ) {
					$contents = file('..includes/languages/' . $language_code . '.php');
					} else {
					return array();
				}
				} else {
				if ( substr(realpath('..includes/languages/' . $language_code . '/' . $filename), 0, strlen(realpath('..includes/languages/' . $language_code))) != realpath('..includes/languages/' . $language_code) ) {
					return array();
				}
				
				if ( !file_exists('..includes/languages/' . $language_code . '/' . $filename) ) {
					return array();
				}
				
				$contents = file('..includes/languages/' . $language_code . '/' . $filename);
			}
			
			$ini_array = array();
			
			foreach ( $contents as $line ) {
				$line = trim($line);
				
				$firstchar = substr($line, 0, 1);
				
				if ( !empty($line) && ( $firstchar != $comment) ) {
					$delimiter = strpos($line, '=');
					
					if ( $delimiter !== false ) {
						$key = trim(substr($line, 0, $delimiter));
						$value = trim(substr($line, $delimiter + 1));
						
						$ini_array[$key] = $value;
						} elseif ( isset($key) ) {
						$ini_array[$key] .= trim($line);
					}
				}
			}
			
			unset($contents);
			
			$this->_definitions = array_merge($this->_definitions, $ini_array);
		}
		
		public function injectDefinitions($file, $language_code = null) {
			if ( is_null($language_code) ) {
				$language_code = $this->_code;
			}
			
			if ( $this->_languages[$language_code]['parent_id'] > 0 ) {
				$this->injectDefinitions($file, $this->getCodeFromID($this->_languages[$language_code]['parent_id']));
			}
			
			foreach ($this->extractDefinitions($language_code . '/' . $file) as $def) {
				$this->_definitions[$def['key']] = $def['value'];
			}
		}
		
		public function &extractDefinitions($xml) {
			$definitions = array();
			
			if ( file_exists(dirname(__FILE__) . '/../../../includes/languages/' . $xml) ) {
				$osC_XML = new osC_XML(file_get_contents(dirname(__FILE__) . '/../../../includes/languages/' . $xml));
				
				$definitions = $osC_XML->toArray();
				
				if (isset($definitions['language']['definitions']['definition'][0]) === false) {
					$definitions['language']['definitions']['definition'] = array($definitions['language']['definitions']['definition']);
				}
				
				$definitions = $definitions['language']['definitions']['definition'];
			}
			
			return $definitions;
		}
		
		function getData($id, $key = null) {
			global $osC_Database;
			
			$Qlanguage = tep_db_query("select * from osc_languages where languages_id = '" . $id . "'");
			$result = tep_db_fetch_array($Qlanguage);			
			
			if ( empty($key) ) {
				return $result;
				} else {
				return $result[$key];
			}
		}
		
		function getID($code = null) {
			global $osC_Database;
			
			if ( empty($code) ) {
				return $this->_languages[$this->_code]['id'];
			}
			$Qlanguage = tep_db_query("select languages_id from osc_languages where code = '" . $code . "'");			
			
			$result = tep_db_fetch_array($Qlanguage);
			
			
			return $result['languages_id'];
		}
		
		function getCode($id = null) {
			global $osC_Database;
			
			if ( empty($id) ) {
				return $this->_code;
			}
			
			$Qlanguage = tep_db_query("select code from osc_languages where languages_id = '" . $id . "'");
			
			$result = tep_db_fetch_array($Qlanguage);
			
			return $result['code'];
		}
		
		function showImage($code = null, $width = '16', $height = '10', $parameters = null) {
			if ( empty($code) ) {
				$code = $this->_code;
			}
			
			$image_code = strtolower(substr($code, 3));
			
			if ( !is_numeric($width) ) {
				$width = 16;
			}
			
			if ( !is_numeric($height) ) {
				$height = 10;
			}
			
			return osc_image('../images/worldflags/' . $image_code . '.png', $this->_languages[$code]['name'], $width, $height, $parameters);
		}
		
		function isDefined($key) {
			return isset($this->_definitions[$key]);
		}
	}
?>
