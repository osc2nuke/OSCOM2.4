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

  class sb_twitter_button {
    var $code = 'sb_twitter_button';
    var $title;
    var $description;
    var $sort_order;
    var $icon = 'twitter.png';
    var $enabled = false;

    function sb_twitter_button() {
      $this->title = MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_TITLE;
      $this->public_title = MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_PUBLIC_TITLE;
      $this->description = MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_DESCRIPTION;

      if ( defined('MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_STATUS') ) {
        $this->sort_order = MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_SORT_ORDER;
        $this->enabled = (MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_STATUS == 'True');
      }
    }

    function getOutput() {
      $params = array('url=' . urlencode(OSCOM::link('product_info.php', 'products_id=' . $_GET['products_id'], 'NONSSL', false)));

      if ( strlen(MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_ACCOUNT) > 0 ) {
        $params[] = 'via=' . urlencode(MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_ACCOUNT);
      }

      if ( strlen(MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_RELATED_ACCOUNT) > 0 ) {
        $params[] = 'related=' . urlencode(MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_RELATED_ACCOUNT) . ((strlen(MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_RELATED_ACCOUNT_DESC) > 0) ? ':' . urlencode(MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_RELATED_ACCOUNT_DESC) : '');
      }

      if ( MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_COUNT_POSITION == 'Vertical' ) {
        $params[] = 'count=vertical';
      } elseif ( MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_COUNT_POSITION == 'None' ) {
        $params[] = 'count=none';
      }

      $params = implode('&', $params);

      return '<script src="http://platform.twitter.com/widgets.js" type="text/javascript"></script><a href="http://twitter.com/share?' . $params . '" target="_blank" class="twitter-share-button">' . tep_output_string_protected($this->public_title) . '</a>';
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
      return defined('MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_STATUS');
    }

    function install() {
      $OSCOM_Db = Registry::get('Db');

      $OSCOM_Db->save('configuration', [
        'configuration_title' => 'Enable Twitter Button Module',
        'configuration_key' => 'MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_STATUS',
        'configuration_value' => 'True',
        'configuration_description' => 'Do you want to allow products to be shared through Twitter Button?',
        'configuration_group_id' => '6',
        'sort_order' => '1',
        'set_function' => 'tep_cfg_select_option(array(\'True\', \'False\'), ',
        'date_added' => 'now()'
      ]);

      $OSCOM_Db->save('configuration', [
        'configuration_title' => 'Shop Owner Twitter Account',
        'configuration_key' => 'MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_ACCOUNT',
        'configuration_value' => '',
        'configuration_description' => 'The Twitter account to attribute the tweet to and is recommended to the user to follow.',
        'configuration_group_id' => '6',
        'sort_order' => '1',
        'date_added' => 'now()'
      ]);

      $OSCOM_Db->save('configuration', [
        'configuration_title' => 'Related Twitter Account',
        'configuration_key' => 'MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_RELATED_ACCOUNT',
        'configuration_value' => '',
        'configuration_description' => 'A related Twitter account that is also recommended to the user to follow.',
        'configuration_group_id' => '6',
        'sort_order' => '1',
        'date_added' => 'now()'
      ]);

      $OSCOM_Db->save('configuration', [
        'configuration_title' => 'Related Twitter Account Description',
        'configuration_key' => 'MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_RELATED_ACCOUNT_DESC',
        'configuration_value' => '',
        'configuration_description' => 'A description for the related Twitter account.',
        'configuration_group_id' => '6',
        'sort_order' => '1',
        'date_added' => 'now()'
      ]);

      $OSCOM_Db->save('configuration', [
        'configuration_title' => 'Count Position',
        'configuration_key' => 'MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_COUNT_POSITION',
        'configuration_value' => 'Horizontal',
        'configuration_description' => 'The position of the counter.',
        'configuration_group_id' => '6',
        'sort_order' => '1',
        'set_function' => 'tep_cfg_select_option(array(\'Horizontal\', \'Vertical\', \'None\'), ',
        'date_added' => 'now()'
      ]);

      $OSCOM_Db->save('configuration', [
        'configuration_title' => 'Sort Order',
        'configuration_key' => 'MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_SORT_ORDER',
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
      return array('MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_STATUS', 'MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_ACCOUNT', 'MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_RELATED_ACCOUNT', 'MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_RELATED_ACCOUNT_DESC', 'MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_COUNT_POSITION', 'MODULE_SOCIAL_BOOKMARKS_TWITTER_BUTTON_SORT_ORDER');
    }
  }
?>