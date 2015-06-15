# $Id$
#
# osCommerce, Open Source E-Commerce Solutions
# http://www.oscommerce.com
#
# Copyright (c) 2015 osCommerce
#
# Released under the GNU General Public License
#
# NOTE: * Please make any modifications to this file by hand!
#       * DO NOT use a mysqldump created file for new changes!
#       * Please take note of the table structure, and use this
#         structure as a standard for future modifications!

DROP TABLE IF EXISTS action_recorder;
CREATE TABLE action_recorder (
  id int NOT NULL auto_increment,
  module varchar(255) NOT NULL,
  user_id int,
  user_name varchar(255),
  identifier varchar(255) NOT NULL,
  success char(1),
  date_added datetime NOT NULL,
  PRIMARY KEY (id),
  KEY idx_action_recorder_module (module),
  KEY idx_action_recorder_user_id (user_id),
  KEY idx_action_recorder_identifier (identifier),
  KEY idx_action_recorder_date_added (date_added)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS address_book;
CREATE TABLE address_book (
   address_book_id int NOT NULL auto_increment,
   customers_id int NOT NULL,
   entry_gender char(1),
   entry_company varchar(255),
   entry_firstname varchar(255) NOT NULL,
   entry_lastname varchar(255) NOT NULL,
   entry_street_address varchar(255) NOT NULL,
   entry_suburb varchar(255),
   entry_postcode varchar(255) NOT NULL,
   entry_city varchar(255) NOT NULL,
   entry_state varchar(255),
   entry_country_id int DEFAULT '0' NOT NULL,
   entry_zone_id int DEFAULT '0' NOT NULL,
   PRIMARY KEY (address_book_id),
   KEY idx_address_book_customers_id (customers_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS address_format;
CREATE TABLE address_format (
  address_format_id int NOT NULL auto_increment,
  address_format varchar(128) NOT NULL,
  address_summary varchar(48) NOT NULL,
  PRIMARY KEY (address_format_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS administrators;
CREATE TABLE administrators (
  id int NOT NULL auto_increment,
  user_name varchar(255) binary NOT NULL,
  user_password varchar(60) NOT NULL,
  PRIMARY KEY (id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS banners;
CREATE TABLE banners (
  banners_id int NOT NULL auto_increment,
  banners_title varchar(64) NOT NULL,
  banners_url varchar(255) NOT NULL,
  banners_image varchar(64) NOT NULL,
  banners_group varchar(10) NOT NULL,
  banners_html_text text,
  expires_impressions int(7) DEFAULT '0',
  expires_date datetime DEFAULT NULL,
  date_scheduled datetime DEFAULT NULL,
  date_added datetime NOT NULL,
  date_status_change datetime DEFAULT NULL,
  status int(1) DEFAULT '1' NOT NULL,
  PRIMARY KEY (banners_id),
  KEY idx_banners_group (banners_group)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS banners_history;
CREATE TABLE banners_history (
  banners_history_id int NOT NULL auto_increment,
  banners_id int NOT NULL,
  banners_shown int(5) NOT NULL DEFAULT '0',
  banners_clicked int(5) NOT NULL DEFAULT '0',
  banners_history_date datetime NOT NULL,
  PRIMARY KEY (banners_history_id),
  KEY idx_banners_history_banners_id (banners_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
   categories_id int NOT NULL auto_increment,
   categories_image varchar(64),
   parent_id int DEFAULT '0' NOT NULL,
   sort_order int(3),
   date_added datetime,
   last_modified datetime,
   PRIMARY KEY (categories_id),
   KEY idx_categories_parent_id (parent_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS categories_description;
CREATE TABLE categories_description (
   categories_id int DEFAULT '0' NOT NULL,
   language_id int DEFAULT '1' NOT NULL,
   categories_name varchar(32) NOT NULL,
   PRIMARY KEY (categories_id, language_id),
   KEY idx_categories_name (categories_name)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS configuration;
CREATE TABLE configuration (
  configuration_id int NOT NULL auto_increment,
  configuration_title varchar(255) NOT NULL,
  configuration_key varchar(255) NOT NULL,
  configuration_value text NOT NULL,
  configuration_description varchar(255) NOT NULL,
  configuration_group_id int NOT NULL,
  sort_order int(5) NULL,
  last_modified datetime NULL,
  date_added datetime NOT NULL,
  use_function varchar(255) NULL,
  set_function varchar(255) NULL,
  PRIMARY KEY (configuration_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS configuration_group;
CREATE TABLE configuration_group (
  configuration_group_id int NOT NULL auto_increment,
  configuration_group_title varchar(64) NOT NULL,
  configuration_group_description varchar(255) NOT NULL,
  sort_order int(5) NULL,
  visible int(1) DEFAULT '1' NULL,
  PRIMARY KEY (configuration_group_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS counter;
CREATE TABLE counter (
  startdate char(8),
  counter int(12)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS counter_history;
CREATE TABLE counter_history (
  month char(8),
  counter int(12)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
  countries_id int NOT NULL auto_increment,
  countries_name varchar(255) NOT NULL,
  countries_iso_code_2 char(2) NOT NULL,
  countries_iso_code_3 char(3) NOT NULL,
  address_format_id int NOT NULL,
  PRIMARY KEY (countries_id),
  KEY IDX_COUNTRIES_NAME (countries_name)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS currencies;
CREATE TABLE currencies (
  currencies_id int NOT NULL auto_increment,
  title varchar(32) NOT NULL,
  code char(3) NOT NULL,
  symbol_left varchar(12),
  symbol_right varchar(12),
  decimal_point char(1),
  thousands_point char(1),
  decimal_places char(1),
  value float(13,8),
  last_updated datetime NULL,
  PRIMARY KEY (currencies_id),
  KEY idx_currencies_code (code)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
   customers_id int NOT NULL auto_increment,
   customers_gender char(1),
   customers_firstname varchar(255) NOT NULL,
   customers_lastname varchar(255) NOT NULL,
   customers_dob datetime DEFAULT '0000-00-00 00:00:00' NOT NULL,
   customers_email_address varchar(255) NOT NULL,
   customers_default_address_id int,
   customers_telephone varchar(255) NOT NULL,
   customers_fax varchar(255),
   customers_password varchar(60) NOT NULL,
   customers_newsletter char(1),
   PRIMARY KEY (customers_id),
   KEY idx_customers_email_address (customers_email_address)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS customers_basket;
CREATE TABLE customers_basket (
  customers_basket_id int NOT NULL auto_increment,
  customers_id int NOT NULL,
  products_id tinytext NOT NULL,
  customers_basket_quantity int(2) NOT NULL,
  final_price decimal(15,4),
  customers_basket_date_added char(8),
  PRIMARY KEY (customers_basket_id),
  KEY idx_customers_basket_customers_id (customers_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS customers_basket_attributes;
CREATE TABLE customers_basket_attributes (
  customers_basket_attributes_id int NOT NULL auto_increment,
  customers_id int NOT NULL,
  products_id tinytext NOT NULL,
  products_options_id int NOT NULL,
  products_options_value_id int NOT NULL,
  PRIMARY KEY (customers_basket_attributes_id),
  KEY idx_customers_basket_att_customers_id (customers_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS customers_info;
CREATE TABLE customers_info (
  customers_info_id int NOT NULL,
  customers_info_date_of_last_logon datetime,
  customers_info_number_of_logons int(5),
  customers_info_date_account_created datetime,
  customers_info_date_account_last_modified datetime,
  global_product_notifications int(1) DEFAULT '0',
  password_reset_key char(40),
  password_reset_date datetime,
  PRIMARY KEY (customers_info_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS languages;
CREATE TABLE languages (
  languages_id int NOT NULL auto_increment,
  name varchar(32)  NOT NULL,
  code char(2) NOT NULL,
  image varchar(64),
  directory varchar(32),
  sort_order int(3),
  PRIMARY KEY (languages_id),
  KEY IDX_LANGUAGES_NAME (name)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS manufacturers;
CREATE TABLE manufacturers (
  manufacturers_id int NOT NULL auto_increment,
  manufacturers_name varchar(32) NOT NULL,
  manufacturers_image varchar(64),
  date_added datetime NULL,
  last_modified datetime NULL,
  PRIMARY KEY (manufacturers_id),
  KEY IDX_MANUFACTURERS_NAME (manufacturers_name)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS manufacturers_info;
CREATE TABLE manufacturers_info (
  manufacturers_id int NOT NULL,
  languages_id int NOT NULL,
  manufacturers_url varchar(255) NOT NULL,
  url_clicked int(5) NOT NULL default '0',
  date_last_click datetime NULL,
  PRIMARY KEY (manufacturers_id, languages_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS newsletters;
CREATE TABLE newsletters (
  newsletters_id int NOT NULL auto_increment,
  title varchar(255) NOT NULL,
  content text NOT NULL,
  module varchar(255) NOT NULL,
  date_added datetime NOT NULL,
  date_sent datetime,
  status int(1),
  locked int(1) DEFAULT '0',
  PRIMARY KEY (newsletters_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  orders_id int NOT NULL auto_increment,
  customers_id int NOT NULL,
  customers_name varchar(255) NOT NULL,
  customers_company varchar(255),
  customers_street_address varchar(255) NOT NULL,
  customers_suburb varchar(255),
  customers_city varchar(255) NOT NULL,
  customers_postcode varchar(255) NOT NULL,
  customers_state varchar(255),
  customers_country varchar(255) NOT NULL,
  customers_telephone varchar(255) NOT NULL,
  customers_email_address varchar(255) NOT NULL,
  customers_address_format_id int(5) NOT NULL,
  delivery_name varchar(255) NOT NULL,
  delivery_company varchar(255),
  delivery_street_address varchar(255) NOT NULL,
  delivery_suburb varchar(255),
  delivery_city varchar(255) NOT NULL,
  delivery_postcode varchar(255) NOT NULL,
  delivery_state varchar(255),
  delivery_country varchar(255) NOT NULL,
  delivery_address_format_id int(5) NOT NULL,
  billing_name varchar(255) NOT NULL,
  billing_company varchar(255),
  billing_street_address varchar(255) NOT NULL,
  billing_suburb varchar(255),
  billing_city varchar(255) NOT NULL,
  billing_postcode varchar(255) NOT NULL,
  billing_state varchar(255),
  billing_country varchar(255) NOT NULL,
  billing_address_format_id int(5) NOT NULL,
  payment_method varchar(255) NOT NULL,
  cc_type varchar(20),
  cc_owner varchar(255),
  cc_number varchar(32),
  cc_expires varchar(4),
  last_modified datetime,
  date_purchased datetime,
  orders_status int(5) NOT NULL,
  orders_date_finished datetime,
  currency char(3),
  currency_value decimal(14,6),
  PRIMARY KEY (orders_id),
  KEY idx_orders_customers_id (customers_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  orders_products_id int NOT NULL auto_increment,
  orders_id int NOT NULL,
  products_id int NOT NULL,
  products_model varchar(12),
  products_name varchar(64) NOT NULL,
  products_price decimal(15,4) NOT NULL,
  final_price decimal(15,4) NOT NULL,
  products_tax decimal(7,4) NOT NULL,
  products_quantity int(2) NOT NULL,
  products_full_id varchar(64) NOT NULL,
  PRIMARY KEY (orders_products_id),
  KEY idx_orders_products_orders_id (orders_id),
  KEY idx_orders_products_products_id (products_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS orders_status;
CREATE TABLE orders_status (
   orders_status_id int DEFAULT '0' NOT NULL,
   language_id int DEFAULT '1' NOT NULL,
   orders_status_name varchar(32) NOT NULL,
   public_flag int DEFAULT '1',
   downloads_flag int DEFAULT '0',
   PRIMARY KEY (orders_status_id, language_id),
   KEY idx_orders_status_name (orders_status_name)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS orders_status_history;
CREATE TABLE orders_status_history (
   orders_status_history_id int NOT NULL auto_increment,
   orders_id int NOT NULL,
   orders_status_id int(5) NOT NULL,
   date_added datetime NOT NULL,
   customer_notified int(1) DEFAULT '0',
   comments text,
   PRIMARY KEY (orders_status_history_id),
   KEY idx_orders_status_history_orders_id (orders_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS orders_products_attributes;
CREATE TABLE orders_products_attributes (
  orders_products_attributes_id int NOT NULL auto_increment,
  orders_id int NOT NULL,
  orders_products_id int NOT NULL,
  products_options varchar(32) NOT NULL,
  products_options_values varchar(32) NOT NULL,
  options_values_price decimal(15,4) NOT NULL,
  price_prefix char(1) NOT NULL,
  PRIMARY KEY (orders_products_attributes_id),
  KEY idx_orders_products_att_orders_id (orders_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS orders_products_download;
CREATE TABLE orders_products_download (
  orders_products_download_id int NOT NULL auto_increment,
  orders_id int NOT NULL default '0',
  orders_products_id int NOT NULL default '0',
  orders_products_filename varchar(255) NOT NULL default '',
  download_maxdays int(2) NOT NULL default '0',
  download_count int(2) NOT NULL default '0',
  PRIMARY KEY  (orders_products_download_id),
  KEY idx_orders_products_download_orders_id (orders_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS orders_total;
CREATE TABLE orders_total (
  orders_total_id int unsigned NOT NULL auto_increment,
  orders_id int NOT NULL,
  title varchar(255) NOT NULL,
  text varchar(255) NOT NULL,
  value decimal(15,4) NOT NULL,
  class varchar(32) NOT NULL,
  sort_order int NOT NULL,
  PRIMARY KEY (orders_total_id),
  KEY idx_orders_total_orders_id (orders_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS osc_languages;
CREATE TABLE osc_languages (
  languages_id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(255) NOT NULL,
  code char(5) NOT NULL,
  locale varchar(255) NOT NULL,
  charset varchar(32) NOT NULL,
  date_format_short varchar(32) NOT NULL,
  date_format_long varchar(32) NOT NULL,
  time_format varchar(32) NOT NULL,
  text_direction varchar(12) NOT NULL,
  currencies_id int(11) NOT NULL,
  numeric_separator_decimal varchar(12) NOT NULL,
  numeric_separator_thousands varchar(12) NOT NULL,
  parent_id int(11) DEFAULT '0',
  sort_order int(11) DEFAULT NULL,
  PRIMARY KEY (languages_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS osc_languages_definitions;
CREATE TABLE osc_languages_definitions (
  id int(11) NOT NULL AUTO_INCREMENT,
  languages_id int(11) NOT NULL,
  content_group varchar(255) NOT NULL,
  definition_key varchar(255) NOT NULL,
  definition_value text NOT NULL,
  PRIMARY KEY (id),
  KEY IDX_LANGUAGES_DEFINITIONS_LANGUAGES (languages_id),
  KEY IDX_LANGUAGES_DEFINITIONS (languages_id,content_group),
  KEY IDX_LANGUAGES_DEFINITIONS_GROUPS (content_group)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;


DROP TABLE IF EXISTS products;
CREATE TABLE products (
  products_id int NOT NULL auto_increment,
  products_quantity int(4) NOT NULL,
  products_model varchar(12),
  products_image varchar(64),
  products_price decimal(15,4) NOT NULL,
  products_date_added datetime NOT NULL,
  products_last_modified datetime,
  products_date_available datetime,
  products_weight decimal(5,2) NOT NULL,
  products_status tinyint(1) NOT NULL,
  products_tax_class_id int NOT NULL,
  manufacturers_id int NULL,
  products_ordered int NOT NULL default '0',
  PRIMARY KEY (products_id),
  KEY idx_products_model (products_model),
  KEY idx_products_date_added (products_date_added)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS products_attributes;
CREATE TABLE products_attributes (
  products_attributes_id int NOT NULL auto_increment,
  products_id int NOT NULL,
  options_id int NOT NULL,
  options_values_id int NOT NULL,
  options_values_price decimal(15,4) NOT NULL,
  price_prefix char(1) NOT NULL,
  PRIMARY KEY (products_attributes_id),
  KEY idx_products_attributes_products_id (products_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS products_attributes_download;
CREATE TABLE products_attributes_download (
  products_attributes_id int NOT NULL,
  products_attributes_filename varchar(255) NOT NULL default '',
  products_attributes_maxdays int(2) default '0',
  products_attributes_maxcount int(2) default '0',
  PRIMARY KEY  (products_attributes_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS products_description;
CREATE TABLE products_description (
  products_id int NOT NULL auto_increment,
  language_id int NOT NULL default '1',
  products_name varchar(64) NOT NULL default '',
  products_description text,
  products_url varchar(255) default NULL,
  products_viewed int(5) default '0',
  PRIMARY KEY  (products_id,language_id),
  KEY products_name (products_name)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS products_images;
CREATE TABLE products_images (
  id int NOT NULL auto_increment,
  products_id int NOT NULL,
  image varchar(64),
  htmlcontent text,
  sort_order int NOT NULL,
  PRIMARY KEY (id),
  KEY products_images_prodid (products_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS products_notifications;
CREATE TABLE products_notifications (
  products_id int NOT NULL,
  customers_id int NOT NULL,
  date_added datetime NOT NULL,
  PRIMARY KEY (products_id, customers_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS products_options;
CREATE TABLE products_options (
  products_options_id int NOT NULL default '0',
  language_id int NOT NULL default '1',
  products_options_name varchar(32) NOT NULL default '',
  PRIMARY KEY  (products_options_id,language_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS products_options_values;
CREATE TABLE products_options_values (
  products_options_values_id int NOT NULL default '0',
  language_id int NOT NULL default '1',
  products_options_values_name varchar(64) NOT NULL default '',
  PRIMARY KEY  (products_options_values_id,language_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS products_options_values_to_products_options;
CREATE TABLE products_options_values_to_products_options (
  products_options_values_to_products_options_id int NOT NULL auto_increment,
  products_options_id int NOT NULL,
  products_options_values_id int NOT NULL,
  PRIMARY KEY (products_options_values_to_products_options_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS products_to_categories;
CREATE TABLE products_to_categories (
  products_id int NOT NULL,
  categories_id int NOT NULL,
  PRIMARY KEY (products_id,categories_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews (
  reviews_id int NOT NULL auto_increment,
  products_id int NOT NULL,
  customers_id int,
  customers_name varchar(255) NOT NULL,
  reviews_rating int(1),
  date_added datetime,
  last_modified datetime,
  reviews_status tinyint(1) NOT NULL default '0',
  reviews_read int(5) NOT NULL default '0',
  PRIMARY KEY (reviews_id),
  KEY idx_reviews_products_id (products_id),
  KEY idx_reviews_customers_id (customers_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS reviews_description;
CREATE TABLE reviews_description (
  reviews_id int NOT NULL,
  languages_id int NOT NULL,
  reviews_text text NOT NULL,
  PRIMARY KEY (reviews_id, languages_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS sec_directory_whitelist;
CREATE TABLE sec_directory_whitelist (
  id int NOT NULL auto_increment,
  directory varchar(255) NOT NULL,
  PRIMARY KEY (id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS sessions;
CREATE TABLE sessions (
  sesskey varchar(128) NOT NULL,
  expiry int(11) unsigned NOT NULL,
  value text NOT NULL,
  PRIMARY KEY (sesskey)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS specials;
CREATE TABLE specials (
  specials_id int NOT NULL auto_increment,
  products_id int NOT NULL,
  specials_new_products_price decimal(15,4) NOT NULL,
  specials_date_added datetime,
  specials_last_modified datetime,
  expires_date datetime,
  date_status_change datetime,
  status int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (specials_id),
  KEY idx_specials_products_id (products_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS tax_class;
CREATE TABLE tax_class (
  tax_class_id int NOT NULL auto_increment,
  tax_class_title varchar(32) NOT NULL,
  tax_class_description varchar(255) NOT NULL,
  last_modified datetime NULL,
  date_added datetime NOT NULL,
  PRIMARY KEY (tax_class_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS tax_rates;
CREATE TABLE tax_rates (
  tax_rates_id int NOT NULL auto_increment,
  tax_zone_id int NOT NULL,
  tax_class_id int NOT NULL,
  tax_priority int(5) DEFAULT 1,
  tax_rate decimal(7,4) NOT NULL,
  tax_description varchar(255) NOT NULL,
  last_modified datetime NULL,
  date_added datetime NOT NULL,
  PRIMARY KEY (tax_rates_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS geo_zones;
CREATE TABLE geo_zones (
  geo_zone_id int NOT NULL auto_increment,
  geo_zone_name varchar(32) NOT NULL,
  geo_zone_description varchar(255) NOT NULL,
  last_modified datetime NULL,
  date_added datetime NOT NULL,
  PRIMARY KEY (geo_zone_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS whos_online;
CREATE TABLE whos_online (
  customer_id int,
  full_name varchar(255) NOT NULL,
  session_id varchar(128) NOT NULL,
  ip_address varchar(15) NOT NULL,
  time_entry varchar(14) NOT NULL,
  time_last_click varchar(14) NOT NULL,
  last_page_url text NOT NULL,
  KEY idx_whos_online_session_id (session_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS zones;
CREATE TABLE zones (
  zone_id int NOT NULL auto_increment,
  zone_country_id int NOT NULL,
  zone_code varchar(32) NOT NULL,
  zone_name varchar(255) NOT NULL,
  PRIMARY KEY (zone_id),
  KEY idx_zones_country_id (zone_country_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS zones_to_geo_zones;
CREATE TABLE zones_to_geo_zones (
   association_id int NOT NULL auto_increment,
   zone_country_id int NOT NULL,
   zone_id int NULL,
   geo_zone_id int NULL,
   last_modified datetime NULL,
   date_added datetime NOT NULL,
   PRIMARY KEY (association_id),
   KEY idx_zones_to_geo_zones_country_id (zone_country_id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

# data

# 1 - Default, 2 - USA, 3 - Spain, 4 - Singapore, 5 - Germany
INSERT INTO address_format VALUES (1, '$firstname $lastname$cr$streets$cr$city, $postcode$cr$statecomma$country','$city / $country');
INSERT INTO address_format VALUES (2, '$firstname $lastname$cr$streets$cr$city, $state    $postcode$cr$country','$city, $state / $country');
INSERT INTO address_format VALUES (3, '$firstname $lastname$cr$streets$cr$city$cr$postcode - $statecomma$country','$state / $country');
INSERT INTO address_format VALUES (4, '$firstname $lastname$cr$streets$cr$city ($postcode)$cr$country', '$postcode / $country');
INSERT INTO address_format VALUES (5, '$firstname $lastname$cr$streets$cr$postcode $city$cr$country','$city / $country');

INSERT INTO banners VALUES (1, 'osCommerce', 'http://www.oscommerce.com', 'banners/oscommerce.gif', 'footer', '', 0, null, null, now(), null, 1);

INSERT INTO categories VALUES ('1', 'category_hardware.gif', '0', '1', now(), null);
INSERT INTO categories VALUES ('2', 'category_software.gif', '0', '2', now(), null);
INSERT INTO categories VALUES ('3', 'category_dvd_movies.gif', '0', '3', now(), null);
INSERT INTO categories VALUES ('4', 'subcategory_graphic_cards.gif', '1', '0', now(), null);
INSERT INTO categories VALUES ('5', 'subcategory_printers.gif', '1', '0', now(), null);
INSERT INTO categories VALUES ('6', 'subcategory_monitors.gif', '1', '0', now(), null);
INSERT INTO categories VALUES ('7', 'subcategory_speakers.gif', '1', '0', now(), null);
INSERT INTO categories VALUES ('8', 'subcategory_keyboards.gif', '1', '0', now(), null);
INSERT INTO categories VALUES ('9', 'subcategory_mice.gif', '1', '0', now(), null);
INSERT INTO categories VALUES ('10', 'subcategory_action.gif', '3', '0', now(), null);
INSERT INTO categories VALUES ('11', 'subcategory_science_fiction.gif', '3', '0', now(), null);
INSERT INTO categories VALUES ('12', 'subcategory_comedy.gif', '3', '0', now(), null);
INSERT INTO categories VALUES ('13', 'subcategory_cartoons.gif', '3', '0', now(), null);
INSERT INTO categories VALUES ('14', 'subcategory_thriller.gif', '3', '0', now(), null);
INSERT INTO categories VALUES ('15', 'subcategory_drama.gif', '3', '0', now(), null);
INSERT INTO categories VALUES ('16', 'subcategory_memory.gif', '1', '0', now(), null);
INSERT INTO categories VALUES ('17', 'subcategory_cdrom_drives.gif', '1', '0', now(), null);
INSERT INTO categories VALUES ('18', 'subcategory_simulation.gif', '2', '0', now(), null);
INSERT INTO categories VALUES ('19', 'subcategory_action_games.gif', '2', '0', now(), null);
INSERT INTO categories VALUES ('20', 'subcategory_strategy.gif', '2', '0', now(), null);
INSERT INTO categories VALUES ('21', 'category_gadgets.png', '0', '4', now(), null);

INSERT INTO categories_description VALUES ( '1', '1', 'Hardware');
INSERT INTO categories_description VALUES ( '2', '1', 'Software');
INSERT INTO categories_description VALUES ( '3', '1', 'DVD Movies');
INSERT INTO categories_description VALUES ( '4', '1', 'Graphics Cards');
INSERT INTO categories_description VALUES ( '5', '1', 'Printers');
INSERT INTO categories_description VALUES ( '6', '1', 'Monitors');
INSERT INTO categories_description VALUES ( '7', '1', 'Speakers');
INSERT INTO categories_description VALUES ( '8', '1', 'Keyboards');
INSERT INTO categories_description VALUES ( '9', '1', 'Mice');
INSERT INTO categories_description VALUES ( '10', '1', 'Action');
INSERT INTO categories_description VALUES ( '11', '1', 'Science Fiction');
INSERT INTO categories_description VALUES ( '12', '1', 'Comedy');
INSERT INTO categories_description VALUES ( '13', '1', 'Cartoons');
INSERT INTO categories_description VALUES ( '14', '1', 'Thriller');
INSERT INTO categories_description VALUES ( '15', '1', 'Drama');
INSERT INTO categories_description VALUES ( '16', '1', 'Memory');
INSERT INTO categories_description VALUES ( '17', '1', 'CDROM Drives');
INSERT INTO categories_description VALUES ( '18', '1', 'Simulation');
INSERT INTO categories_description VALUES ( '19', '1', 'Action');
INSERT INTO categories_description VALUES ( '20', '1', 'Strategy');
INSERT INTO categories_description VALUES ( '21', '1', 'Gadgets');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Store Name', 'STORE_NAME', 'osCommerce', 'The name of my store', '1', '1', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Store Owner', 'STORE_OWNER', 'Harald Ponce de Leon', 'The name of my store owner', '1', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('E-Mail Address', 'STORE_OWNER_EMAIL_ADDRESS', 'root@localhost', 'The e-mail address of my store owner', '1', '3', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('E-Mail From', 'EMAIL_FROM', 'osCommerce <root@localhost>', 'The e-mail address used in (sent) e-mails', '1', '4', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Country', 'STORE_COUNTRY', '223', 'The country my store is located in <br /><br /><strong>Note: Please remember to update the store zone.</strong>', '1', '6', 'tep_get_country_name', 'tep_cfg_pull_down_country_list(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Zone', 'STORE_ZONE', '18', 'The zone my store is located in', '1', '7', 'tep_cfg_get_zone_name', 'tep_cfg_pull_down_zone_list(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Expected Sort Order', 'EXPECTED_PRODUCTS_SORT', 'desc', 'This is the sort order used in the expected products box.', '1', '8', 'tep_cfg_select_option(array(\'asc\', \'desc\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Expected Sort Field', 'EXPECTED_PRODUCTS_FIELD', 'date_expected', 'The column to sort by in the expected products box.', '1', '9', 'tep_cfg_select_option(array(\'products_name\', \'date_expected\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Switch To Default Language Currency', 'USE_DEFAULT_LANGUAGE_CURRENCY', 'false', 'Automatically switch to the language\'s currency when it is changed', '1', '10', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Send Extra Order Emails To', 'SEND_EXTRA_ORDER_EMAILS_TO', '', 'Send extra order emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', '1', '11', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Use Search-Engine Safe URLs', 'SEARCH_ENGINE_FRIENDLY_URLS', 'false', 'Use search-engine safe urls for all site links', '1', '12', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Display Cart After Adding Product', 'DISPLAY_CART', 'true', 'Display the shopping cart after adding a product (or return back to their origin)', '1', '14', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Allow Guest To Tell A Friend', 'ALLOW_GUEST_TO_TELL_A_FRIEND', 'false', 'Allow guests to tell a friend about a product', '1', '15', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Default Search Operator', 'ADVANCED_SEARCH_DEFAULT_OPERATOR', 'and', 'Default search operators', '1', '17', 'tep_cfg_select_option(array(\'and\', \'or\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Store Address', 'STORE_ADDRESS', 'Address\nCountry', 'This is the Store Address used on printable documents and displayed online', '1', '18', 'tep_cfg_textarea(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Store Phone', 'STORE_PHONE', '01 234 5678', 'This is the Store Phone used on printable documents and displayed online', '1', '19', 'tep_cfg_textarea(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Tax Decimal Places', 'TAX_DECIMAL_PLACES', '0', 'Pad the tax value this amount of decimal places', '1', '21', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Display Prices with Tax', 'DISPLAY_PRICE_WITH_TAX', 'false', 'Display prices with tax included (true) or add the tax at the end (false)', '1', '22', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('First Name', 'ENTRY_FIRST_NAME_MIN_LENGTH', '2', 'Minimum length of first name', '2', '1', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Last Name', 'ENTRY_LAST_NAME_MIN_LENGTH', '2', 'Minimum length of last name', '2', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Date of Birth', 'ENTRY_DOB_MIN_LENGTH', '10', 'Minimum length of date of birth', '2', '3', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Street Address', 'ENTRY_STREET_ADDRESS_MIN_LENGTH', '5', 'Minimum length of street address', '2', '5', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Post Code', 'ENTRY_POSTCODE_MIN_LENGTH', '4', 'Minimum length of post code', '2', '7', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('City', 'ENTRY_CITY_MIN_LENGTH', '3', 'Minimum length of city', '2', '8', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Telephone Number', 'ENTRY_TELEPHONE_MIN_LENGTH', '3', 'Minimum length of telephone number', '2', '10', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Password', 'ENTRY_PASSWORD_MIN_LENGTH', '5', 'Minimum length of password', '2', '11', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Review Text', 'REVIEW_TEXT_MIN_LENGTH', '50', 'Minimum length of review text', '2', '14', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Best Sellers', 'MIN_DISPLAY_BESTSELLERS', '1', 'Minimum number of best sellers to display', '2', '15', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Also Purchased', 'MIN_DISPLAY_ALSO_PURCHASED', '1', 'Minimum number of products to display in the \'This Customer Also Purchased\' box', '2', '16', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Address Book Entries', 'MAX_ADDRESS_BOOK_ENTRIES', '5', 'Maximum address book entries a customer is allowed to have', '3', '1', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Products List', 'MAX_DISPLAY_SEARCH_RESULTS', '20', 'Amount of products to list', '3', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Page Links', 'MAX_DISPLAY_PAGE_LINKS', '5', 'Number of \'number\' links use for page-sets', '3', '3', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('New Products Module', 'MAX_DISPLAY_NEW_PRODUCTS', '9', 'Maximum number of new products to display in a category', '3', '5', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Products Expected', 'MAX_DISPLAY_UPCOMING_PRODUCTS', '10', 'Maximum number of products expected to display', '3', '6', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Manufacturers List', 'MAX_DISPLAY_MANUFACTURERS_IN_A_LIST', '0', 'Used in manufacturers box; when the number of manufacturers exceeds this number, a drop-down list will be displayed instead of the default list', '3', '7', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Manufacturers Select Size', 'MAX_MANUFACTURERS_LIST', '1', 'Used in manufacturers box; when this value is \'1\' the classic drop-down list will be used for the manufacturers box. Otherwise, a list-box with the specified number of rows will be displayed.', '3', '7', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Length of Manufacturers Name', 'MAX_DISPLAY_MANUFACTURER_NAME_LEN', '15', 'Used in manufacturers box; maximum length of manufacturers name to display', '3', '8', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('New Reviews', 'MAX_DISPLAY_NEW_REVIEWS', '6', 'Maximum number of new reviews to display', '3', '9', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Selection of Random Reviews', 'MAX_RANDOM_SELECT_REVIEWS', '10', 'How many records to select from to choose one random product review', '3', '10', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Selection of Random New Products', 'MAX_RANDOM_SELECT_NEW', '10', 'How many records to select from to choose one random new product to display', '3', '11', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Selection of Products on Special', 'MAX_RANDOM_SELECT_SPECIALS', '10', 'How many records to select from to choose one random product special to display', '3', '12', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Best Sellers', 'MAX_DISPLAY_BESTSELLERS', '10', 'Maximum number of best sellers to display', '3', '15', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Also Purchased', 'MAX_DISPLAY_ALSO_PURCHASED', '6', 'Maximum number of products to display in the \'This Customer Also Purchased\' box', '3', '16', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Customer Order History Box', 'MAX_DISPLAY_PRODUCTS_IN_ORDER_HISTORY_BOX', '6', 'Maximum number of products to display in the customer order history box', '3', '17', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Order History', 'MAX_DISPLAY_ORDER_HISTORY', '10', 'Maximum number of orders to display in the order history page', '3', '18', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Product Quantities In Shopping Cart', 'MAX_QTY_IN_CART', '99', 'Maximum number of product quantities that can be added to the shopping cart (0 for no limit)', '3', '19', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Small Image Width', 'SMALL_IMAGE_WIDTH', '100', 'The pixel width of small images', '4', '1', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Small Image Height', 'SMALL_IMAGE_HEIGHT', '80', 'The pixel height of small images', '4', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Heading Image Width', 'HEADING_IMAGE_WIDTH', '57', 'The pixel width of heading images', '4', '3', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Heading Image Height', 'HEADING_IMAGE_HEIGHT', '40', 'The pixel height of heading images', '4', '4', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Subcategory Image Width', 'SUBCATEGORY_IMAGE_WIDTH', '100', 'The pixel width of subcategory images', '4', '5', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Subcategory Image Height', 'SUBCATEGORY_IMAGE_HEIGHT', '57', 'The pixel height of subcategory images', '4', '6', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Calculate Image Size', 'CONFIG_CALCULATE_IMAGE_SIZE', 'true', 'Calculate the size of images?', '4', '7', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Image Required', 'IMAGE_REQUIRED', 'true', 'Enable to display broken images. Good for development.', '4', '8', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Gender', 'ACCOUNT_GENDER', 'true', 'Display gender in the customers account', '5', '1', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Date of Birth', 'ACCOUNT_DOB', 'true', 'Display date of birth in the customers account', '5', '2', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Company', 'ACCOUNT_COMPANY', 'true', 'Display company in the customers account', '5', '3', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Suburb', 'ACCOUNT_SUBURB', 'true', 'Display suburb in the customers account', '5', '4', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('State', 'ACCOUNT_STATE', 'true', 'Display state in the customers account', '5', '5', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Installed Modules', 'MODULE_PAYMENT_INSTALLED', 'cod.php;paypal_express.php', 'List of payment module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: cod.php;paypal_express.php)', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Installed Modules', 'MODULE_ORDER_TOTAL_INSTALLED', 'ot_subtotal.php;ot_tax.php;ot_shipping.php;ot_total.php', 'List of order_total module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ot_subtotal.php;ot_tax.php;ot_shipping.php;ot_total.php)', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Installed Modules', 'MODULE_SHIPPING_INSTALLED', 'flat.php', 'List of shipping module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ups.php;flat.php;item.php)', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Installed Modules', 'MODULE_ACTION_RECORDER_INSTALLED', 'ar_admin_login.php;ar_contact_us.php;ar_reset_password.php;ar_tell_a_friend.php', 'List of action recorder module filenames separated by a semi-colon. This is automatically updated. No need to edit.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Installed Modules', 'MODULE_SOCIAL_BOOKMARKS_INSTALLED', 'sb_email.php;sb_facebook.php;sb_google_plus_share.php;sb_pinterest.php;sb_twitter.php', 'List of social bookmark module filenames separated by a semi-colon. This is automatically updated. No need to edit.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Enable Cash On Delivery Module', 'MODULE_PAYMENT_COD_STATUS', 'True', 'Do you want to accept Cash On Delevery payments?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Payment Zone', 'MODULE_PAYMENT_COD_ZONE', '0', 'If a zone is selected, only enable this payment method for that zone.', '6', '2', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Sort order of display.', 'MODULE_PAYMENT_COD_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, use_function, date_added) VALUES ('Set Order Status', 'MODULE_PAYMENT_COD_ORDER_STATUS_ID', '0', 'Set the status of orders made with this payment module to this value', '6', '0', 'tep_cfg_pull_down_order_statuses(', 'tep_get_order_status_name', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Enable Flat Shipping', 'MODULE_SHIPPING_FLAT_STATUS', 'True', 'Do you want to offer flat rate shipping?', '6', '0', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Shipping Cost', 'MODULE_SHIPPING_FLAT_COST', '5.00', 'The shipping cost for all orders using this shipping method.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Tax Class', 'MODULE_SHIPPING_FLAT_TAX_CLASS', '0', 'Use the following tax class on the shipping fee.', '6', '0', 'tep_get_tax_class_title', 'tep_cfg_pull_down_tax_classes(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Shipping Zone', 'MODULE_SHIPPING_FLAT_ZONE', '0', 'If a zone is selected, only enable this shipping method for that zone.', '6', '0', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Sort Order', 'MODULE_SHIPPING_FLAT_SORT_ORDER', '0', 'Sort order of display.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Default Currency', 'DEFAULT_CURRENCY', 'USD', 'Default Currency', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Default Language', 'DEFAULT_LANGUAGE', 'en_US', 'Default Language', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Default Order Status For New Orders', 'DEFAULT_ORDERS_STATUS_ID', '1', 'When a new order is created, this order status will be assigned to it.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Display Shipping', 'MODULE_ORDER_TOTAL_SHIPPING_STATUS', 'true', 'Do you want to display the order shipping cost?', '6', '1','tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Sort Order', 'MODULE_ORDER_TOTAL_SHIPPING_SORT_ORDER', '2', 'Sort order of display.', '6', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Allow Free Shipping', 'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING', 'false', 'Do you want to allow free shipping?', '6', '3', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, date_added) VALUES ('Free Shipping For Orders Over', 'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING_OVER', '50', 'Provide free shipping for orders over the set amount.', '6', '4', 'currencies->format', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Provide Free Shipping For Orders Made', 'MODULE_ORDER_TOTAL_SHIPPING_DESTINATION', 'national', 'Provide free shipping for orders sent to the set destination.', '6', '5', 'tep_cfg_select_option(array(\'national\', \'international\', \'both\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Display Sub-Total', 'MODULE_ORDER_TOTAL_SUBTOTAL_STATUS', 'true', 'Do you want to display the order sub-total cost?', '6', '1','tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Sort Order', 'MODULE_ORDER_TOTAL_SUBTOTAL_SORT_ORDER', '1', 'Sort order of display.', '6', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Display Tax', 'MODULE_ORDER_TOTAL_TAX_STATUS', 'true', 'Do you want to display the order tax value?', '6', '1','tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Sort Order', 'MODULE_ORDER_TOTAL_TAX_SORT_ORDER', '3', 'Sort order of display.', '6', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Display Total', 'MODULE_ORDER_TOTAL_TOTAL_STATUS', 'true', 'Do you want to display the total order value?', '6', '1','tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Sort Order', 'MODULE_ORDER_TOTAL_TOTAL_SORT_ORDER', '4', 'Sort order of display.', '6', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Minimum Minutes Per E-Mail', 'MODULE_ACTION_RECORDER_CONTACT_US_EMAIL_MINUTES', '15', 'Minimum number of minutes to allow 1 e-mail to be sent (eg, 15 for 1 e-mail every 15 minutes)', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Minimum Minutes Per E-Mail', 'MODULE_ACTION_RECORDER_TELL_A_FRIEND_EMAIL_MINUTES', '15', 'Minimum number of minutes to allow 1 e-mail to be sent (eg, 15 for 1 e-mail every 15 minutes)', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Allowed Minutes', 'MODULE_ACTION_RECORDER_ADMIN_LOGIN_MINUTES', '5', 'Number of minutes to allow login attempts to occur.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Allowed Attempts', 'MODULE_ACTION_RECORDER_ADMIN_LOGIN_ATTEMPTS', '3', 'Number of login attempts to allow within the specified period.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Allowed Minutes', 'MODULE_ACTION_RECORDER_RESET_PASSWORD_MINUTES', '5', 'Number of minutes to allow password resets to occur.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Allowed Attempts', 'MODULE_ACTION_RECORDER_RESET_PASSWORD_ATTEMPTS', '1', 'Number of password reset attempts to allow within the specified period.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable E-Mail Module', 'MODULE_SOCIAL_BOOKMARKS_EMAIL_STATUS', 'True', 'Do you want to allow products to be shared through e-mail?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_SOCIAL_BOOKMARKS_EMAIL_SORT_ORDER', '10', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Google+ Share Module', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS_SHARE_STATUS', 'True', 'Do you want to allow products to be shared through Google+?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Annotation', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS_SHARE_ANNOTATION', 'None', 'The annotation to display next to the button.', '6', '1', 'tep_cfg_select_option(array(\'Inline\', \'Bubble\', \'Vertical-Bubble\', \'None\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Width', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS_SHARE_WIDTH', '', 'The maximum width of the button.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Height', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS_SHARE_HEIGHT', '15', 'Sets the height of the button.', '6', '1', 'tep_cfg_select_option(array(\'15\', \'20\', \'24\', \'60\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Alignment', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS_SHARE_ALIGN', 'Left', 'The alignment of the button assets.', '6', '1', 'tep_cfg_select_option(array(\'Left\', \'Right\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS_SHARE_SORT_ORDER', '20', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Facebook Module', 'MODULE_SOCIAL_BOOKMARKS_FACEBOOK_STATUS', 'True', 'Do you want to allow products to be shared through Facebook?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_SOCIAL_BOOKMARKS_FACEBOOK_SORT_ORDER', '30', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Twitter Module', 'MODULE_SOCIAL_BOOKMARKS_TWITTER_STATUS', 'True', 'Do you want to allow products to be shared through Twitter?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_SOCIAL_BOOKMARKS_TWITTER_SORT_ORDER', '40', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Pinterest Module', 'MODULE_SOCIAL_BOOKMARKS_PINTEREST_STATUS', 'True', 'Do you want to allow Pinterest Button?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Layout Position', 'MODULE_SOCIAL_BOOKMARKS_PINTEREST_BUTTON_COUNT_POSITION', 'None', 'Horizontal or Vertical or None', '6', '2', 'tep_cfg_select_option(array(\'Horizontal\', \'Vertical\', \'None\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_SOCIAL_BOOKMARKS_PINTEREST_SORT_ORDER', '50', 'Sort order of display. Lowest is displayed first.', '6', '0', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Country of Origin', 'SHIPPING_ORIGIN_COUNTRY', '223', 'Select the country of origin to be used in shipping quotes.', '7', '1', 'tep_get_country_name', 'tep_cfg_pull_down_country_list(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Postal Code', 'SHIPPING_ORIGIN_ZIP', 'NONE', 'Enter the Postal Code (ZIP) of the Store to be used in shipping quotes.', '7', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Enter the Maximum Package Weight you will ship', 'SHIPPING_MAX_WEIGHT', '50', 'Carriers have a max weight limit for a single package. This is a common one for all.', '7', '3', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Package Tare weight.', 'SHIPPING_BOX_WEIGHT', '3', 'What is the weight of typical packaging of small to medium packages?', '7', '4', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Larger packages - percentage increase.', 'SHIPPING_BOX_PADDING', '10', 'For 10% enter 10', '7', '5', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Allow Orders Not Matching Defined Shipping Zones ', 'SHIPPING_ALLOW_UNDEFINED_ZONES', 'False', 'Should orders be allowed to shipping addresses not matching defined shipping module shipping zones?', '7', '5', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Image', 'PRODUCT_LIST_IMAGE', '1', 'Do you want to display the Product Image?', '8', '1', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Manufacturer Name','PRODUCT_LIST_MANUFACTURER', '0', 'Do you want to display the Product Manufacturer Name?', '8', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Model', 'PRODUCT_LIST_MODEL', '0', 'Do you want to display the Product Model?', '8', '3', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Name', 'PRODUCT_LIST_NAME', '2', 'Do you want to display the Product Name?', '8', '4', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Price', 'PRODUCT_LIST_PRICE', '3', 'Do you want to display the Product Price', '8', '5', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Quantity', 'PRODUCT_LIST_QUANTITY', '0', 'Do you want to display the Product Quantity?', '8', '6', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Weight', 'PRODUCT_LIST_WEIGHT', '0', 'Do you want to display the Product Weight?', '8', '7', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Buy Now Button', 'PRODUCT_LIST_BUY_NOW', '4', 'Do you want to display the Buy Now Button?', '8', '8', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Category/Manufacturer Filter (0=disable; 1=enable)', 'PRODUCT_LIST_FILTER', '1', 'Do you want to display the Category/Manufacturer Filter?', '8', '9', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Location of Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)', 'PREV_NEXT_BAR_LOCATION', '2', 'Sets the location of the Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)', '8', '10', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Check stock level', 'STOCK_CHECK', 'true', 'Check to see if sufficent stock is available', '9', '1', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Subtract stock', 'STOCK_LIMITED', 'true', 'Subtract product in stock by product orders', '9', '2', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Allow Checkout', 'STOCK_ALLOW_CHECKOUT', 'true', 'Allow customer to checkout even if there is insufficient stock', '9', '3', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Mark product out of stock', 'STOCK_MARK_PRODUCT_OUT_OF_STOCK', '***', 'Display something on screen so customer can see which product has insufficient stock', '9', '4', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Stock Re-order level', 'STOCK_REORDER_LEVEL', '5', 'Define when stock needs to be re-ordered', '9', '5', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Store Page Parse Time', 'STORE_PAGE_PARSE_TIME', 'false', 'Store the time it takes to parse a page', '10', '1', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Log Destination', 'STORE_PAGE_PARSE_TIME_LOG', '/var/log/www/tep/page_parse_time.log', 'Directory and filename of the page parse time log', '10', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Log Date Format', 'STORE_PARSE_DATE_TIME_FORMAT', '%d/%m/%Y %H:%M:%S', 'The date format', '10', '3', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Display The Page Parse Time', 'DISPLAY_PAGE_PARSE_TIME', 'true', 'Display the page parse time (store page parse time must be enabled)', '10', '4', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Store Database Queries', 'STORE_DB_TRANSACTIONS', 'false', 'Store the database queries in the page parse time log', '10', '5', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Use Cache', 'USE_CACHE', 'false', 'Use caching features', '11', '1', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Cache Directory', 'DIR_FS_CACHE', '/tmp/', 'The directory where the cached files are saved', '11', '2', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('E-Mail Transport Method', 'EMAIL_TRANSPORT', 'sendmail', 'Defines if this server uses a local connection to sendmail or uses an SMTP connection via TCP/IP. Servers running on Windows and MacOS should change this setting to SMTP.', '12', '1', 'tep_cfg_select_option(array(\'sendmail\', \'smtp\'),', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('E-Mail Linefeeds', 'EMAIL_LINEFEED', 'LF', 'Defines the character sequence used to separate mail headers.', '12', '2', 'tep_cfg_select_option(array(\'LF\', \'CRLF\'),', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Use MIME HTML When Sending Emails', 'EMAIL_USE_HTML', 'false', 'Send e-mails in HTML format', '12', '3', 'tep_cfg_select_option(array(\'true\', \'false\'),', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Verify E-Mail Addresses Through DNS', 'ENTRY_EMAIL_ADDRESS_CHECK', 'false', 'Verify e-mail address through a DNS server', '12', '4', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Send E-Mails', 'SEND_EMAILS', 'true', 'Send out e-mails', '12', '5', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Enable download', 'DOWNLOAD_ENABLED', 'false', 'Enable the products download functions.', '13', '1', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Download by redirect', 'DOWNLOAD_BY_REDIRECT', 'false', 'Use browser redirection for download. Disable on non-Unix systems.', '13', '2', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Expiry delay (days)' ,'DOWNLOAD_MAX_DAYS', '7', 'Set number of days before the download link expires. 0 means no limit.', '13', '3', '', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Maximum number of downloads' ,'DOWNLOAD_MAX_COUNT', '5', 'Set the maximum number of downloads. 0 means no download authorized.', '13', '4', '', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Enable GZip Compression', 'GZIP_COMPRESSION', 'false', 'Enable HTTP GZip compression.', '14', '1', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Compression Level', 'GZIP_LEVEL', '5', 'Use this compression level 0-9 (0 = minimum, 9 = maximum).', '14', '2', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Session Directory', 'SESSION_WRITE_DIRECTORY', '/tmp', 'If sessions are file based, store them in this directory.', '15', '1', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Force Cookie Use', 'SESSION_FORCE_COOKIE_USE', 'False', 'Force the use of sessions when cookies are only enabled.', '15', '2', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Check SSL Session ID', 'SESSION_CHECK_SSL_SESSION_ID', 'False', 'Validate the SSL_SESSION_ID on every secure HTTPS page request.', '15', '3', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Check User Agent', 'SESSION_CHECK_USER_AGENT', 'False', 'Validate the clients browser user agent on every page request.', '15', '4', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Check IP Address', 'SESSION_CHECK_IP_ADDRESS', 'False', 'Validate the clients IP address on every page request.', '15', '5', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Prevent Spider Sessions', 'SESSION_BLOCK_SPIDERS', 'True', 'Prevent known spiders from starting a session.', '15', '6', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Recreate Session', 'SESSION_RECREATE', 'True', 'Recreate the session to generate a new session ID when the customer logs on or creates an account (PHP >=4.1 needed).', '15', '7', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Last Update Check Time', 'LAST_UPDATE_CHECK_TIME', '', 'Last time a check for new versions of osCommerce was run', '6', '0', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added) VALUES ('Store Logo', 'STORE_LOGO', 'store_logo.png', 'This is the filename of your Store Logo.  This should be updated at Admin > Configuration > Store Logo', '6', '0', NULL, now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Bootstrap Container', 'BOOTSTRAP_CONTAINER', 'container-fluid', 'What type of container should the page content be shown in? See http://getbootstrap.com/css/#overview-container', '16', '1', 'tep_cfg_select_option(array(\'container-fluid\', \'container\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Bootstrap Content', 'BOOTSTRAP_CONTENT', '8', 'What width should the page content default to?  (8 = two thirds width, 6 = half width, 4 = one third width) Note that the Side Column(s) - if installed - will adjust automatically.', '16', '2', 'tep_cfg_select_option(array(\'8\', \'6\', \'4\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Service Modules', 'MODULE_SERVICES_INSTALLED',  'language', 'Installed services modules', '6', '0', now());

INSERT INTO configuration_group VALUES ('1', 'My Store', 'General information about my store', '1', '1');
INSERT INTO configuration_group VALUES ('2', 'Minimum Values', 'The minimum values for functions / data', '2', '1');
INSERT INTO configuration_group VALUES ('3', 'Maximum Values', 'The maximum values for functions / data', '3', '1');
INSERT INTO configuration_group VALUES ('4', 'Images', 'Image parameters', '4', '1');
INSERT INTO configuration_group VALUES ('5', 'Customer Details', 'Customer account configuration', '5', '1');
INSERT INTO configuration_group VALUES ('6', 'Module Options', 'Hidden from configuration', '6', '0');
INSERT INTO configuration_group VALUES ('7', 'Shipping/Packaging', 'Shipping options available at my store', '7', '1');
INSERT INTO configuration_group VALUES ('8', 'Product Listing', 'Product Listing    configuration options', '8', '1');
INSERT INTO configuration_group VALUES ('9', 'Stock', 'Stock configuration options', '9', '1');
INSERT INTO configuration_group VALUES ('10', 'Logging', 'Logging configuration options', '10', '1');
INSERT INTO configuration_group VALUES ('11', 'Cache', 'Caching configuration options', '11', '1');
INSERT INTO configuration_group VALUES ('12', 'E-Mail Options', 'General setting for E-Mail transport and HTML E-Mails', '12', '1');
INSERT INTO configuration_group VALUES ('13', 'Download', 'Downloadable products options', '13', '1');
INSERT INTO configuration_group VALUES ('14', 'GZip Compression', 'GZip compression options', '14', '1');
INSERT INTO configuration_group VALUES ('15', 'Sessions', 'Session options', '15', '1');
INSERT INTO configuration_group VALUES ('16', 'Bootstrap Setup', 'Bootstrap Options', '16', '1');

INSERT INTO countries VALUES (1,'Afghanistan','AF','AFG','1');
INSERT INTO countries VALUES (2,'Albania','AL','ALB','1');
INSERT INTO countries VALUES (3,'Algeria','DZ','DZA','1');
INSERT INTO countries VALUES (4,'American Samoa','AS','ASM','1');
INSERT INTO countries VALUES (5,'Andorra','AD','AND','1');
INSERT INTO countries VALUES (6,'Angola','AO','AGO','1');
INSERT INTO countries VALUES (7,'Anguilla','AI','AIA','1');
INSERT INTO countries VALUES (8,'Antarctica','AQ','ATA','1');
INSERT INTO countries VALUES (9,'Antigua and Barbuda','AG','ATG','1');
INSERT INTO countries VALUES (10,'Argentina','AR','ARG','1');
INSERT INTO countries VALUES (11,'Armenia','AM','ARM','1');
INSERT INTO countries VALUES (12,'Aruba','AW','ABW','1');
INSERT INTO countries VALUES (13,'Australia','AU','AUS','1');
INSERT INTO countries VALUES (14,'Austria','AT','AUT','5');
INSERT INTO countries VALUES (15,'Azerbaijan','AZ','AZE','1');
INSERT INTO countries VALUES (16,'Bahamas','BS','BHS','1');
INSERT INTO countries VALUES (17,'Bahrain','BH','BHR','1');
INSERT INTO countries VALUES (18,'Bangladesh','BD','BGD','1');
INSERT INTO countries VALUES (19,'Barbados','BB','BRB','1');
INSERT INTO countries VALUES (20,'Belarus','BY','BLR','1');
INSERT INTO countries VALUES (21,'Belgium','BE','BEL','1');
INSERT INTO countries VALUES (22,'Belize','BZ','BLZ','1');
INSERT INTO countries VALUES (23,'Benin','BJ','BEN','1');
INSERT INTO countries VALUES (24,'Bermuda','BM','BMU','1');
INSERT INTO countries VALUES (25,'Bhutan','BT','BTN','1');
INSERT INTO countries VALUES (26,'Bolivia','BO','BOL','1');
INSERT INTO countries VALUES (27,'Bosnia and Herzegowina','BA','BIH','1');
INSERT INTO countries VALUES (28,'Botswana','BW','BWA','1');
INSERT INTO countries VALUES (29,'Bouvet Island','BV','BVT','1');
INSERT INTO countries VALUES (30,'Brazil','BR','BRA','1');
INSERT INTO countries VALUES (31,'British Indian Ocean Territory','IO','IOT','1');
INSERT INTO countries VALUES (32,'Brunei Darussalam','BN','BRN','1');
INSERT INTO countries VALUES (33,'Bulgaria','BG','BGR','1');
INSERT INTO countries VALUES (34,'Burkina Faso','BF','BFA','1');
INSERT INTO countries VALUES (35,'Burundi','BI','BDI','1');
INSERT INTO countries VALUES (36,'Cambodia','KH','KHM','1');
INSERT INTO countries VALUES (37,'Cameroon','CM','CMR','1');
INSERT INTO countries VALUES (38,'Canada','CA','CAN','1');
INSERT INTO countries VALUES (39,'Cape Verde','CV','CPV','1');
INSERT INTO countries VALUES (40,'Cayman Islands','KY','CYM','1');
INSERT INTO countries VALUES (41,'Central African Republic','CF','CAF','1');
INSERT INTO countries VALUES (42,'Chad','TD','TCD','1');
INSERT INTO countries VALUES (43,'Chile','CL','CHL','1');
INSERT INTO countries VALUES (44,'China','CN','CHN','1');
INSERT INTO countries VALUES (45,'Christmas Island','CX','CXR','1');
INSERT INTO countries VALUES (46,'Cocos (Keeling) Islands','CC','CCK','1');
INSERT INTO countries VALUES (47,'Colombia','CO','COL','1');
INSERT INTO countries VALUES (48,'Comoros','KM','COM','1');
INSERT INTO countries VALUES (49,'Congo','CG','COG','1');
INSERT INTO countries VALUES (50,'Cook Islands','CK','COK','1');
INSERT INTO countries VALUES (51,'Costa Rica','CR','CRI','1');
INSERT INTO countries VALUES (52,'Cote D\'Ivoire','CI','CIV','1');
INSERT INTO countries VALUES (53,'Croatia','HR','HRV','1');
INSERT INTO countries VALUES (54,'Cuba','CU','CUB','1');
INSERT INTO countries VALUES (55,'Cyprus','CY','CYP','1');
INSERT INTO countries VALUES (56,'Czech Republic','CZ','CZE','1');
INSERT INTO countries VALUES (57,'Denmark','DK','DNK','1');
INSERT INTO countries VALUES (58,'Djibouti','DJ','DJI','1');
INSERT INTO countries VALUES (59,'Dominica','DM','DMA','1');
INSERT INTO countries VALUES (60,'Dominican Republic','DO','DOM','1');
INSERT INTO countries VALUES (61,'East Timor','TP','TMP','1');
INSERT INTO countries VALUES (62,'Ecuador','EC','ECU','1');
INSERT INTO countries VALUES (63,'Egypt','EG','EGY','1');
INSERT INTO countries VALUES (64,'El Salvador','SV','SLV','1');
INSERT INTO countries VALUES (65,'Equatorial Guinea','GQ','GNQ','1');
INSERT INTO countries VALUES (66,'Eritrea','ER','ERI','1');
INSERT INTO countries VALUES (67,'Estonia','EE','EST','1');
INSERT INTO countries VALUES (68,'Ethiopia','ET','ETH','1');
INSERT INTO countries VALUES (69,'Falkland Islands (Malvinas)','FK','FLK','1');
INSERT INTO countries VALUES (70,'Faroe Islands','FO','FRO','1');
INSERT INTO countries VALUES (71,'Fiji','FJ','FJI','1');
INSERT INTO countries VALUES (72,'Finland','FI','FIN','1');
INSERT INTO countries VALUES (73,'France','FR','FRA','1');
INSERT INTO countries VALUES (74,'France, Metropolitan','FX','FXX','1');
INSERT INTO countries VALUES (75,'French Guiana','GF','GUF','1');
INSERT INTO countries VALUES (76,'French Polynesia','PF','PYF','1');
INSERT INTO countries VALUES (77,'French Southern Territories','TF','ATF','1');
INSERT INTO countries VALUES (78,'Gabon','GA','GAB','1');
INSERT INTO countries VALUES (79,'Gambia','GM','GMB','1');
INSERT INTO countries VALUES (80,'Georgia','GE','GEO','1');
INSERT INTO countries VALUES (81,'Germany','DE','DEU','5');
INSERT INTO countries VALUES (82,'Ghana','GH','GHA','1');
INSERT INTO countries VALUES (83,'Gibraltar','GI','GIB','1');
INSERT INTO countries VALUES (84,'Greece','GR','GRC','1');
INSERT INTO countries VALUES (85,'Greenland','GL','GRL','1');
INSERT INTO countries VALUES (86,'Grenada','GD','GRD','1');
INSERT INTO countries VALUES (87,'Guadeloupe','GP','GLP','1');
INSERT INTO countries VALUES (88,'Guam','GU','GUM','1');
INSERT INTO countries VALUES (89,'Guatemala','GT','GTM','1');
INSERT INTO countries VALUES (90,'Guinea','GN','GIN','1');
INSERT INTO countries VALUES (91,'Guinea-bissau','GW','GNB','1');
INSERT INTO countries VALUES (92,'Guyana','GY','GUY','1');
INSERT INTO countries VALUES (93,'Haiti','HT','HTI','1');
INSERT INTO countries VALUES (94,'Heard and Mc Donald Islands','HM','HMD','1');
INSERT INTO countries VALUES (95,'Honduras','HN','HND','1');
INSERT INTO countries VALUES (96,'Hong Kong','HK','HKG','1');
INSERT INTO countries VALUES (97,'Hungary','HU','HUN','1');
INSERT INTO countries VALUES (98,'Iceland','IS','ISL','1');
INSERT INTO countries VALUES (99,'India','IN','IND','1');
INSERT INTO countries VALUES (100,'Indonesia','ID','IDN','1');
INSERT INTO countries VALUES (101,'Iran (Islamic Republic of)','IR','IRN','1');
INSERT INTO countries VALUES (102,'Iraq','IQ','IRQ','1');
INSERT INTO countries VALUES (103,'Ireland','IE','IRL','1');
INSERT INTO countries VALUES (104,'Israel','IL','ISR','1');
INSERT INTO countries VALUES (105,'Italy','IT','ITA','1');
INSERT INTO countries VALUES (106,'Jamaica','JM','JAM','1');
INSERT INTO countries VALUES (107,'Japan','JP','JPN','1');
INSERT INTO countries VALUES (108,'Jordan','JO','JOR','1');
INSERT INTO countries VALUES (109,'Kazakhstan','KZ','KAZ','1');
INSERT INTO countries VALUES (110,'Kenya','KE','KEN','1');
INSERT INTO countries VALUES (111,'Kiribati','KI','KIR','1');
INSERT INTO countries VALUES (112,'Korea, Democratic People\'s Republic of','KP','PRK','1');
INSERT INTO countries VALUES (113,'Korea, Republic of','KR','KOR','1');
INSERT INTO countries VALUES (114,'Kuwait','KW','KWT','1');
INSERT INTO countries VALUES (115,'Kyrgyzstan','KG','KGZ','1');
INSERT INTO countries VALUES (116,'Lao People\'s Democratic Republic','LA','LAO','1');
INSERT INTO countries VALUES (117,'Latvia','LV','LVA','1');
INSERT INTO countries VALUES (118,'Lebanon','LB','LBN','1');
INSERT INTO countries VALUES (119,'Lesotho','LS','LSO','1');
INSERT INTO countries VALUES (120,'Liberia','LR','LBR','1');
INSERT INTO countries VALUES (121,'Libyan Arab Jamahiriya','LY','LBY','1');
INSERT INTO countries VALUES (122,'Liechtenstein','LI','LIE','1');
INSERT INTO countries VALUES (123,'Lithuania','LT','LTU','1');
INSERT INTO countries VALUES (124,'Luxembourg','LU','LUX','1');
INSERT INTO countries VALUES (125,'Macau','MO','MAC','1');
INSERT INTO countries VALUES (126,'Macedonia, The Former Yugoslav Republic of','MK','MKD','1');
INSERT INTO countries VALUES (127,'Madagascar','MG','MDG','1');
INSERT INTO countries VALUES (128,'Malawi','MW','MWI','1');
INSERT INTO countries VALUES (129,'Malaysia','MY','MYS','1');
INSERT INTO countries VALUES (130,'Maldives','MV','MDV','1');
INSERT INTO countries VALUES (131,'Mali','ML','MLI','1');
INSERT INTO countries VALUES (132,'Malta','MT','MLT','1');
INSERT INTO countries VALUES (133,'Marshall Islands','MH','MHL','1');
INSERT INTO countries VALUES (134,'Martinique','MQ','MTQ','1');
INSERT INTO countries VALUES (135,'Mauritania','MR','MRT','1');
INSERT INTO countries VALUES (136,'Mauritius','MU','MUS','1');
INSERT INTO countries VALUES (137,'Mayotte','YT','MYT','1');
INSERT INTO countries VALUES (138,'Mexico','MX','MEX','1');
INSERT INTO countries VALUES (139,'Micronesia, Federated States of','FM','FSM','1');
INSERT INTO countries VALUES (140,'Moldova, Republic of','MD','MDA','1');
INSERT INTO countries VALUES (141,'Monaco','MC','MCO','1');
INSERT INTO countries VALUES (142,'Mongolia','MN','MNG','1');
INSERT INTO countries VALUES (143,'Montserrat','MS','MSR','1');
INSERT INTO countries VALUES (144,'Morocco','MA','MAR','1');
INSERT INTO countries VALUES (145,'Mozambique','MZ','MOZ','1');
INSERT INTO countries VALUES (146,'Myanmar','MM','MMR','1');
INSERT INTO countries VALUES (147,'Namibia','NA','NAM','1');
INSERT INTO countries VALUES (148,'Nauru','NR','NRU','1');
INSERT INTO countries VALUES (149,'Nepal','NP','NPL','1');
INSERT INTO countries VALUES (150,'Netherlands','NL','NLD','1');
INSERT INTO countries VALUES (151,'Netherlands Antilles','AN','ANT','1');
INSERT INTO countries VALUES (152,'New Caledonia','NC','NCL','1');
INSERT INTO countries VALUES (153,'New Zealand','NZ','NZL','1');
INSERT INTO countries VALUES (154,'Nicaragua','NI','NIC','1');
INSERT INTO countries VALUES (155,'Niger','NE','NER','1');
INSERT INTO countries VALUES (156,'Nigeria','NG','NGA','1');
INSERT INTO countries VALUES (157,'Niue','NU','NIU','1');
INSERT INTO countries VALUES (158,'Norfolk Island','NF','NFK','1');
INSERT INTO countries VALUES (159,'Northern Mariana Islands','MP','MNP','1');
INSERT INTO countries VALUES (160,'Norway','NO','NOR','1');
INSERT INTO countries VALUES (161,'Oman','OM','OMN','1');
INSERT INTO countries VALUES (162,'Pakistan','PK','PAK','1');
INSERT INTO countries VALUES (163,'Palau','PW','PLW','1');
INSERT INTO countries VALUES (164,'Panama','PA','PAN','1');
INSERT INTO countries VALUES (165,'Papua New Guinea','PG','PNG','1');
INSERT INTO countries VALUES (166,'Paraguay','PY','PRY','1');
INSERT INTO countries VALUES (167,'Peru','PE','PER','1');
INSERT INTO countries VALUES (168,'Philippines','PH','PHL','1');
INSERT INTO countries VALUES (169,'Pitcairn','PN','PCN','1');
INSERT INTO countries VALUES (170,'Poland','PL','POL','1');
INSERT INTO countries VALUES (171,'Portugal','PT','PRT','1');
INSERT INTO countries VALUES (172,'Puerto Rico','PR','PRI','1');
INSERT INTO countries VALUES (173,'Qatar','QA','QAT','1');
INSERT INTO countries VALUES (174,'Reunion','RE','REU','1');
INSERT INTO countries VALUES (175,'Romania','RO','ROM','1');
INSERT INTO countries VALUES (176,'Russian Federation','RU','RUS','1');
INSERT INTO countries VALUES (177,'Rwanda','RW','RWA','1');
INSERT INTO countries VALUES (178,'Saint Kitts and Nevis','KN','KNA','1');
INSERT INTO countries VALUES (179,'Saint Lucia','LC','LCA','1');
INSERT INTO countries VALUES (180,'Saint Vincent and the Grenadines','VC','VCT','1');
INSERT INTO countries VALUES (181,'Samoa','WS','WSM','1');
INSERT INTO countries VALUES (182,'San Marino','SM','SMR','1');
INSERT INTO countries VALUES (183,'Sao Tome and Principe','ST','STP','1');
INSERT INTO countries VALUES (184,'Saudi Arabia','SA','SAU','1');
INSERT INTO countries VALUES (185,'Senegal','SN','SEN','1');
INSERT INTO countries VALUES (186,'Seychelles','SC','SYC','1');
INSERT INTO countries VALUES (187,'Sierra Leone','SL','SLE','1');
INSERT INTO countries VALUES (188,'Singapore','SG','SGP', '4');
INSERT INTO countries VALUES (189,'Slovakia (Slovak Republic)','SK','SVK','1');
INSERT INTO countries VALUES (190,'Slovenia','SI','SVN','1');
INSERT INTO countries VALUES (191,'Solomon Islands','SB','SLB','1');
INSERT INTO countries VALUES (192,'Somalia','SO','SOM','1');
INSERT INTO countries VALUES (193,'South Africa','ZA','ZAF','1');
INSERT INTO countries VALUES (194,'South Georgia and the South Sandwich Islands','GS','SGS','1');
INSERT INTO countries VALUES (195,'Spain','ES','ESP','3');
INSERT INTO countries VALUES (196,'Sri Lanka','LK','LKA','1');
INSERT INTO countries VALUES (197,'St. Helena','SH','SHN','1');
INSERT INTO countries VALUES (198,'St. Pierre and Miquelon','PM','SPM','1');
INSERT INTO countries VALUES (199,'Sudan','SD','SDN','1');
INSERT INTO countries VALUES (200,'Suriname','SR','SUR','1');
INSERT INTO countries VALUES (201,'Svalbard and Jan Mayen Islands','SJ','SJM','1');
INSERT INTO countries VALUES (202,'Swaziland','SZ','SWZ','1');
INSERT INTO countries VALUES (203,'Sweden','SE','SWE','1');
INSERT INTO countries VALUES (204,'Switzerland','CH','CHE','1');
INSERT INTO countries VALUES (205,'Syrian Arab Republic','SY','SYR','1');
INSERT INTO countries VALUES (206,'Taiwan','TW','TWN','1');
INSERT INTO countries VALUES (207,'Tajikistan','TJ','TJK','1');
INSERT INTO countries VALUES (208,'Tanzania, United Republic of','TZ','TZA','1');
INSERT INTO countries VALUES (209,'Thailand','TH','THA','1');
INSERT INTO countries VALUES (210,'Togo','TG','TGO','1');
INSERT INTO countries VALUES (211,'Tokelau','TK','TKL','1');
INSERT INTO countries VALUES (212,'Tonga','TO','TON','1');
INSERT INTO countries VALUES (213,'Trinidad and Tobago','TT','TTO','1');
INSERT INTO countries VALUES (214,'Tunisia','TN','TUN','1');
INSERT INTO countries VALUES (215,'Turkey','TR','TUR','1');
INSERT INTO countries VALUES (216,'Turkmenistan','TM','TKM','1');
INSERT INTO countries VALUES (217,'Turks and Caicos Islands','TC','TCA','1');
INSERT INTO countries VALUES (218,'Tuvalu','TV','TUV','1');
INSERT INTO countries VALUES (219,'Uganda','UG','UGA','1');
INSERT INTO countries VALUES (220,'Ukraine','UA','UKR','1');
INSERT INTO countries VALUES (221,'United Arab Emirates','AE','ARE','1');
INSERT INTO countries VALUES (222,'United Kingdom','GB','GBR','1');
INSERT INTO countries VALUES (223,'United States','US','USA', '2');
INSERT INTO countries VALUES (224,'United States Minor Outlying Islands','UM','UMI','1');
INSERT INTO countries VALUES (225,'Uruguay','UY','URY','1');
INSERT INTO countries VALUES (226,'Uzbekistan','UZ','UZB','1');
INSERT INTO countries VALUES (227,'Vanuatu','VU','VUT','1');
INSERT INTO countries VALUES (228,'Vatican City State (Holy See)','VA','VAT','1');
INSERT INTO countries VALUES (229,'Venezuela','VE','VEN','1');
INSERT INTO countries VALUES (230,'Viet Nam','VN','VNM','1');
INSERT INTO countries VALUES (231,'Virgin Islands (British)','VG','VGB','1');
INSERT INTO countries VALUES (232,'Virgin Islands (U.S.)','VI','VIR','1');
INSERT INTO countries VALUES (233,'Wallis and Futuna Islands','WF','WLF','1');
INSERT INTO countries VALUES (234,'Western Sahara','EH','ESH','1');
INSERT INTO countries VALUES (235,'Yemen','YE','YEM','1');
INSERT INTO countries VALUES (236,'Yugoslavia','YU','YUG','1');
INSERT INTO countries VALUES (237,'Zaire','ZR','ZAR','1');
INSERT INTO countries VALUES (238,'Zambia','ZM','ZMB','1');
INSERT INTO countries VALUES (239,'Zimbabwe','ZW','ZWE','1');

INSERT INTO currencies VALUES (1,'U.S. Dollar','USD','$','','.',',','2','1.0000', now());
INSERT INTO currencies VALUES (2,'Euro','EUR','','€','.',',','2','1.0000', now());

INSERT INTO languages VALUES (1,'English','en','icon.gif','english',1);

INSERT INTO manufacturers VALUES (1,'Matrox','manufacturer_matrox.gif', now(), null);
INSERT INTO manufacturers VALUES (2,'Microsoft','manufacturer_microsoft.gif', now(), null);
INSERT INTO manufacturers VALUES (3,'Warner','manufacturer_warner.gif', now(), null);
INSERT INTO manufacturers VALUES (4,'Fox','manufacturer_fox.gif', now(), null);
INSERT INTO manufacturers VALUES (5,'Logitech','manufacturer_logitech.gif', now(), null);
INSERT INTO manufacturers VALUES (6,'Canon','manufacturer_canon.gif', now(), null);
INSERT INTO manufacturers VALUES (7,'Sierra','manufacturer_sierra.gif', now(), null);
INSERT INTO manufacturers VALUES (8,'GT Interactive','manufacturer_gt_interactive.gif', now(), null);
INSERT INTO manufacturers VALUES (9,'Hewlett Packard','manufacturer_hewlett_packard.gif', now(), null);
INSERT INTO manufacturers VALUES (10,'Samsung','manufacturer_samsung.png', now(), null);

INSERT INTO manufacturers_info VALUES (1, 1, 'http://www.matrox.com', 0, null);
INSERT INTO manufacturers_info VALUES (2, 1, 'http://www.microsoft.com', 0, null);
INSERT INTO manufacturers_info VALUES (3, 1, 'http://www.warner.com', 0, null);
INSERT INTO manufacturers_info VALUES (4, 1, 'http://www.fox.com', 0, null);
INSERT INTO manufacturers_info VALUES (5, 1, 'http://www.logitech.com', 0, null);
INSERT INTO manufacturers_info VALUES (6, 1, 'http://www.canon.com', 0, null);
INSERT INTO manufacturers_info VALUES (7, 1, 'http://www.sierra.com', 0, null);
INSERT INTO manufacturers_info VALUES (8, 1, 'http://www.infogrames.com', 0, null);
INSERT INTO manufacturers_info VALUES (9, 1, 'http://www.hewlettpackard.com', 0, null);
INSERT INTO manufacturers_info VALUES (10, 1, 'http://www.samsung.com', 0, null);

INSERT INTO orders_status VALUES ( '1', '1', 'Pending', '1', '0');
INSERT INTO orders_status VALUES ( '2', '1', 'Processing', '1', '1');
INSERT INTO orders_status VALUES ( '3', '1', 'Delivered', '1', '1');

INSERT INTO products VALUES (1,32,'MG200MMS','matrox/mg200mms.gif',299.99, now(),null,null,23.00,1,1,1,0);
INSERT INTO products VALUES (2,32,'MG400-32MB','matrox/mg400-32mb.gif',499.99, now(),null,null,23.00,1,1,1,0);
INSERT INTO products VALUES (3,2,'MSIMPRO','microsoft/msimpro.gif',49.99, now(),null,null,7.00,1,1,3,0);
INSERT INTO products VALUES (4,13,'DVD-RPMK','dvd/replacement_killers.gif',42.00, now(),null,null,23.00,1,1,2,0);
INSERT INTO products VALUES (5,17,'DVD-BLDRNDC','dvd/blade_runner.gif',35.99, now(),null,null,7.00,1,1,3,0);
INSERT INTO products VALUES (6,10,'DVD-MATR','dvd/the_matrix.gif',39.99, now(),null,null,7.00,1,1,3,0);
INSERT INTO products VALUES (7,10,'DVD-YGEM','dvd/youve_got_mail.gif',34.99, now(),null,null,7.00,1,1,3,0);
INSERT INTO products VALUES (8,10,'DVD-ABUG','dvd/a_bugs_life.gif',35.99, now(),null,null,7.00,1,1,3,0);
INSERT INTO products VALUES (9,10,'DVD-UNSG','dvd/under_siege.gif',29.99, now(),null,null,7.00,1,1,3,0);
INSERT INTO products VALUES (10,10,'DVD-UNSG2','dvd/under_siege2.gif',29.99, now(),null,null,7.00,1,1,3,0);
INSERT INTO products VALUES (11,10,'DVD-FDBL','dvd/fire_down_below.gif',29.99, now(),null,null,7.00,1,1,3,0);
INSERT INTO products VALUES (12,10,'DVD-DHWV','dvd/die_hard_3.gif',39.99, now(),null,null,7.00,1,1,4,0);
INSERT INTO products VALUES (13,10,'DVD-LTWP','dvd/lethal_weapon.gif',34.99, now(),null,null,7.00,1,1,3,0);
INSERT INTO products VALUES (14,10,'DVD-REDC','dvd/red_corner.gif',32.00, now(),null,null,7.00,1,1,3,0);
INSERT INTO products VALUES (15,10,'DVD-FRAN','dvd/frantic.gif',35.00, now(),null,null,7.00,1,1,3,0);
INSERT INTO products VALUES (16,10,'DVD-CUFI','dvd/courage_under_fire.gif',38.99, now(),null,null,7.00,1,1,4,0);
INSERT INTO products VALUES (17,10,'DVD-SPEED','dvd/speed.gif',39.99, now(),null,null,7.00,1,1,4,0);
INSERT INTO products VALUES (18,10,'DVD-SPEED2','dvd/speed_2.gif',42.00, now(),null,null,7.00,1,1,4,0);
INSERT INTO products VALUES (19,10,'DVD-TSAB','dvd/theres_something_about_mary.gif',49.99, now(),null,null,7.00,1,1,4,0);
INSERT INTO products VALUES (20,10,'DVD-BELOVED','dvd/beloved.gif',54.99, now(),null,null,7.00,1,1,3,0);
INSERT INTO products VALUES (21,16,'PC-SWAT3','sierra/swat_3.gif',79.99, now(),null,null,7.00,1,1,7,0);
INSERT INTO products VALUES (22,13,'PC-UNTM','gt_interactive/unreal_tournament.gif',89.99, now(),null,null,7.00,1,1,8,0);
INSERT INTO products VALUES (23,16,'PC-TWOF','gt_interactive/wheel_of_time.gif',99.99, now(),null,null,10.00,1,1,8,0);
INSERT INTO products VALUES (24,17,'PC-DISC','gt_interactive/disciples.gif',90.00, now(),null,null,8.00,1,1,8,0);
INSERT INTO products VALUES (25,16,'MSINTKB','microsoft/intkeyboardps2.gif',69.99, now(),null,null,8.00,1,1,2,0);
INSERT INTO products VALUES (26,10,'MSIMEXP','microsoft/imexplorer.gif',64.95, now(),null,null,8.00,1,1,2,0);
INSERT INTO products VALUES (27,8,'HPLJ1100XI','hewlett_packard/lj1100xi.gif',499.99, now(),null,null,45.00,1,1,9,0);
INSERT INTO products VALUES (28,100,'GT-P1000','samsung/galaxy_tab.gif',749.99, now(),null,null,1,1,1,10,0);

INSERT INTO products_description VALUES (1,1,'Matrox G200 MMS','Reinforcing its position as a multi-monitor trailblazer, Matrox Graphics Inc. has once again developed the most flexible and highly advanced solution in the industry. Introducing the new Matrox G200 Multi-Monitor Series; the first graphics card ever to support up to four DVI digital flat panel displays on a single 8&quot; PCI board.<br /><br />With continuing demand for digital flat panels in the financial workplace, the Matrox G200 MMS is the ultimate in flexible solutions. The Matrox G200 MMS also supports the new digital video interface (DVI) created by the Digital Display Working Group (DDWG) designed to ease the adoption of digital flat panels. Other configurations include composite video capture ability and onboard TV tuner, making the Matrox G200 MMS the complete solution for business needs.<br /><br />Based on the award-winning MGA-G200 graphics chip, the Matrox G200 Multi-Monitor Series provides superior 2D/3D graphics acceleration to meet the demanding needs of business applications such as real-time stock quotes (Versus), live video feeds (Reuters &amp; Bloombergs), multiple windows applications, word processing, spreadsheets and CAD.','www.matrox.com/mga/products/g200_mms/home.cfm',0);
INSERT INTO products_description VALUES (2,1,'Matrox G400 32MB','<strong>Dramatically Different High Performance Graphics</strong><br /><br />Introducing the Millennium G400 Series - a dramatically different, high performance graphics experience. Armed with the industry\'s fastest graphics chip, the Millennium G400 Series takes explosive acceleration two steps further by adding unprecedented image quality, along with the most versatile display options for all your 3D, 2D and DVD applications. As the most powerful and innovative tools in your PC\'s arsenal, the Millennium G400 Series will not only change the way you see graphics, but will revolutionize the way you use your computer.<br /><br /><strong>Key features:</strong><ul><li>New Matrox G400 256-bit DualBus graphics chip</li><li>Explosive 3D, 2D and DVD performance</li><li>DualHead Display</li><li>Superior DVD and TV output</li><li>3D Environment-Mapped Bump Mapping</li><li>Vibrant Color Quality rendering </li><li>UltraSharp DAC of up to 360 MHz</li><li>3D Rendering Array Processor</li><li>Support for 16 or 32 MB of memory</li></ul>','www.matrox.com/mga/products/mill_g400/home.htm',0);
INSERT INTO products_description VALUES (3,1,'Microsoft IntelliMouse Pro','Every element of IntelliMouse Pro - from its unique arched shape to the texture of the rubber grip around its base - is the product of extensive customer and ergonomic research. Microsoft\'s popular wheel control, which now allows zooming and universal scrolling functions, gives IntelliMouse Pro outstanding comfort and efficiency.','www.microsoft.com/hardware/mouse/intellimouse.asp',0);
INSERT INTO products_description VALUES (4,1,'The Replacement Killers','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />Languages: English, Deutsch.<br />Subtitles: English, Deutsch, Spanish.<br />Audio: Dolby Surround 5.1.<br />Picture Format: 16:9 Wide-Screen.<br />Length: (approx) 80 minutes.<br />Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.replacement-killers.com',0);
INSERT INTO products_description VALUES (5,1,'Blade Runner - Director\'s Cut','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />Languages: English, Deutsch.<br />Subtitles: English, Deutsch, Spanish.<br />Audio: Dolby Surround 5.1.<br />Picture Format: 16:9 Wide-Screen.<br />Length: (approx) 112 minutes.<br />Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.bladerunner.com',0);
INSERT INTO products_description VALUES (6,1,'The Matrix','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch.\r<br />\nAudio: Dolby Surround.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 131 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Making Of.','www.thematrix.com',0);
INSERT INTO products_description VALUES (7,1,'You\'ve Got Mail','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch, Spanish.\r<br />\nSubtitles: English, Deutsch, Spanish, French, Nordic, Polish.\r<br />\nAudio: Dolby Digital 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 115 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.youvegotmail.com',0);
INSERT INTO products_description VALUES (8,1,'A Bug\'s Life','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Digital 5.1 / Dobly Surround Stereo.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 91 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.abugslife.com',0);
INSERT INTO products_description VALUES (9,1,'Under Siege','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 98 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (10,1,'Under Siege 2 - Dark Territory','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 98 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (11,1,'Fire Down Below','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 100 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (12,1,'Die Hard With A Vengeance','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 122 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (13,1,'Lethal Weapon','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 100 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (14,1,'Red Corner','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 117 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (15,1,'Frantic','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 115 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (16,1,'Courage Under Fire','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 112 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (17,1,'Speed','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 112 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (18,1,'Speed 2: Cruise Control','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 120 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (19,1,'There\'s Something About Mary','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 114 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (20,1,'Beloved','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 164 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (21,1,'SWAT 3: Close Quarters Battle','<strong>Windows 95/98</strong><br /><br />211 in progress with shots fired. Officer down. Armed suspects with hostages. Respond Code 3! Los Angles, 2005, In the next seven days, representatives from every nation around the world will converge on Las Angles to witness the signing of the United Nations Nuclear Abolishment Treaty. The protection of these dignitaries falls on the shoulders of one organization, LAPD SWAT. As part of this elite tactical organization, you and your team have the weapons and all the training necessary to protect, to serve, and \"When needed\" to use deadly force to keep the peace. It takes more than weapons to make it through each mission. Your arsenal includes C2 charges, flashbangs, tactical grenades. opti-Wand mini-video cameras, and other devices critical to meeting your objectives and keeping your men free of injury. Uncompromised Duty, Honor and Valor!','www.swat3.com',0);
INSERT INTO products_description VALUES (22,1,'Unreal Tournament','From the creators of the best-selling Unreal, comes Unreal Tournament. A new kind of single player experience. A ruthless multiplayer revolution.<br /><br />This stand-alone game showcases completely new team-based gameplay, groundbreaking multi-faceted single player action or dynamic multi-player mayhem. It\'s a fight to the finish for the title of Unreal Grand Master in the gladiatorial arena. A single player experience like no other! Guide your team of \'bots\' (virtual teamates) against the hardest criminals in the galaxy for the ultimate title - the Unreal Grand Master.','www.unrealtournament.net',0);
INSERT INTO products_description VALUES (23,1,'The Wheel Of Time','The world in which The Wheel of Time takes place is lifted directly out of Jordan\'s pages; it\'s huge and consists of many different environments. How you navigate the world will depend largely on which game - single player or multipayer - you\'re playing. The single player experience, with a few exceptions, will see Elayna traversing the world mainly by foot (with a couple notable exceptions). In the multiplayer experience, your character will have more access to travel via Ter\'angreal, Portal Stones, and the Ways. However you move around, though, you\'ll quickly discover that means of locomotion can easily become the least of the your worries...<br /><br />During your travels, you quickly discover that four locations are crucial to your success in the game. Not surprisingly, these locations are the homes of The Wheel of Time\'s main characters. Some of these places are ripped directly from the pages of Jordan\'s books, made flesh with Legend\'s unparalleled pixel-pushing ways. Other places are specific to the game, conceived and executed with the intent of expanding this game world even further. Either way, they provide a backdrop for some of the most intense first person action and strategy you\'ll have this year.','www.wheeloftime.com',0);
INSERT INTO products_description VALUES (24,1,'Disciples: Sacred Lands','A new age is dawning...<br /><br />Enter the realm of the Sacred Lands, where the dawn of a New Age has set in motion the most momentous of wars. As the prophecies long foretold, four races now clash with swords and sorcery in a desperate bid to control the destiny of their gods. Take on the quest as a champion of the Empire, the Mountain Clans, the Legions of the Damned, or the Undead Hordes and test your faith in battles of brute force, spellbinding magic and acts of guile. Slay demons, vanquish giants and combat merciless forces of the dead and undead. But to ensure the salvation of your god, the hero within must evolve.<br /><br />The day of reckoning has come... and only the chosen will survive.','',0);
INSERT INTO products_description VALUES (25,1,'Microsoft Internet Keyboard PS/2','The Internet Keyboard has 10 Hot Keys on a comfortable standard keyboard design that also includes a detachable palm rest. The Hot Keys allow you to browse the web, or check e-mail directly from your keyboard. The IntelliType Pro software also allows you to customize your hot keys - make the Internet Keyboard work the way you want it to!','',0);
INSERT INTO products_description VALUES (26,1,'Microsoft IntelliMouse Explorer','Microsoft introduces its most advanced mouse, the IntelliMouse Explorer! IntelliMouse Explorer features a sleek design, an industrial-silver finish, a glowing red underside and taillight, creating a style and look unlike any other mouse. IntelliMouse Explorer combines the accuracy and reliability of Microsoft IntelliEye optical tracking technology, the convenience of two new customizable function buttons, the efficiency of the scrolling wheel and the comfort of expert ergonomic design. All these great features make this the best mouse for the PC!','www.microsoft.com/hardware/mouse/explorer.asp',0);
INSERT INTO products_description VALUES (27,1,'Hewlett Packard LaserJet 1100Xi','HP has always set the pace in laser printing technology. The new generation HP LaserJet 1100 series sets another impressive pace, delivering a stunning 8 pages per minute print speed. The 600 dpi print resolution with HP\'s Resolution Enhancement technology (REt) makes every document more professional.<br /><br />Enhanced print speed and laser quality results are just the beginning. With 2MB standard memory, HP LaserJet 1100xi users will be able to print increasingly complex pages. Memory can be increased to 18MB to tackle even more complex documents with ease. The HP LaserJet 1100xi supports key operating systems including Windows 3.1, 3.11, 95, 98, NT 4.0, OS/2 and DOS. Network compatibility available via the optional HP JetDirect External Print Servers.<br /><br />HP LaserJet 1100xi also features The Document Builder for the Web Era from Trellix Corp. (featuring software to create Web documents).','www.pandi.hp.com/pandi-db/prodinfo.main?product=laserjet1100',0);
INSERT INTO products_description VALUES (28,1,'Samsung Galaxy Tab','<p>Powered by a Cortex A8 1.0GHz application processor, the Samsung GALAXY Tab is designed to deliver high performance whenever and wherever you are. At the same time, HD video contents are supported by a wide range of multimedia formats (DivX, XviD, MPEG4, H.263, H.264 and more), which maximizes the joy of entertainment.</p><p>With 3G HSPA connectivity, 802.11n Wi-Fi, and Bluetooth 3.0, the Samsung GALAXY Tab enhances users\' mobile communication on a whole new level. Video conferencing and push email on the large 7-inch display make communication more smooth and efficient. For voice telephony, the Samsung GALAXY Tab turns out to be a perfect speakerphone on the desk, or a mobile phone on the move via Bluetooth headset.</p>','http://galaxytab.samsungmobile.com',0);

INSERT INTO products_attributes VALUES (1,1,4,1,0.00,'+');
INSERT INTO products_attributes VALUES (2,1,4,2,50.00,'+');
INSERT INTO products_attributes VALUES (3,1,4,3,70.00,'+');
INSERT INTO products_attributes VALUES (4,1,3,5,0.00,'+');
INSERT INTO products_attributes VALUES (5,1,3,6,100.00,'+');
INSERT INTO products_attributes VALUES (6,2,4,3,10.00,'-');
INSERT INTO products_attributes VALUES (7,2,4,4,0.00,'+');
INSERT INTO products_attributes VALUES (8,2,3,6,0.00,'+');
INSERT INTO products_attributes VALUES (9,2,3,7,120.00,'+');
INSERT INTO products_attributes VALUES (10,26,3,8,0.00,'+');
INSERT INTO products_attributes VALUES (11,26,3,9,6.00,'+');
INSERT INTO products_attributes VALUES (26, 22, 5, 10, '0.00', '+');
INSERT INTO products_attributes VALUES (27, 22, 5, 13, '0.00', '+');

INSERT INTO products_attributes_download VALUES (26, 'unreal.zip', 7, 3);

INSERT INTO products_images VALUES (1,28,'samsung/galaxy_tab_1.jpg',null,1);
INSERT INTO products_images VALUES (2,28,'samsung/galaxy_tab_2.jpg',null,2);
INSERT INTO products_images VALUES (3,28,'samsung/galaxy_tab_3.jpg',null,3);
INSERT INTO products_images VALUES (4,28,'samsung/galaxy_tab_4.jpg','<iframe width="560" height="315" src="http://www.youtube.com/embed/tAbsmHMAhrQ" frameborder="0" allowfullscreen></iframe>',4);
INSERT INTO products_images VALUES (5,17,'dvd/speed_large.jpg',null,1);
INSERT INTO products_images VALUES (6,12,'dvd/die_hard_3_large.jpg',null,1);
INSERT INTO products_images VALUES (7,11,'dvd/fire_down_below_large.jpg',null,1);
INSERT INTO products_images VALUES (8,13,'dvd/lethal_weapon_large.jpg',null,1);
INSERT INTO products_images VALUES (9,18,'dvd/speed_2_large.jpg',null,1);
INSERT INTO products_images VALUES (10,6,'dvd/the_matrix_large.jpg',null,1);
INSERT INTO products_images VALUES (11,4,'dvd/replacement_killers_large.jpg',null,1);
INSERT INTO products_images VALUES (12,9,'dvd/under_siege_large.jpg',null,1);

INSERT INTO products_options VALUES (1,1,'Color');
INSERT INTO products_options VALUES (2,1,'Size');
INSERT INTO products_options VALUES (3,1,'Model');
INSERT INTO products_options VALUES (4,1,'Memory');
INSERT INTO products_options VALUES (5, 1, 'Version');

INSERT INTO products_options_values VALUES (1,1,'4 mb');
INSERT INTO products_options_values VALUES (2,1,'8 mb');
INSERT INTO products_options_values VALUES (3,1,'16 mb');
INSERT INTO products_options_values VALUES (4,1,'32 mb');
INSERT INTO products_options_values VALUES (5,1,'Value');
INSERT INTO products_options_values VALUES (6,1,'Premium');
INSERT INTO products_options_values VALUES (7,1,'Deluxe');
INSERT INTO products_options_values VALUES (8,1,'PS/2');
INSERT INTO products_options_values VALUES (9,1,'USB');
INSERT INTO products_options_values VALUES (10, 1, 'Download: Windows - English');
INSERT INTO products_options_values VALUES (13, 1, 'Box: Windows - English');

INSERT INTO products_options_values_to_products_options VALUES (1,4,1);
INSERT INTO products_options_values_to_products_options VALUES (2,4,2);
INSERT INTO products_options_values_to_products_options VALUES (3,4,3);
INSERT INTO products_options_values_to_products_options VALUES (4,4,4);
INSERT INTO products_options_values_to_products_options VALUES (5,3,5);
INSERT INTO products_options_values_to_products_options VALUES (6,3,6);
INSERT INTO products_options_values_to_products_options VALUES (7,3,7);
INSERT INTO products_options_values_to_products_options VALUES (8,3,8);
INSERT INTO products_options_values_to_products_options VALUES (9,3,9);
INSERT INTO products_options_values_to_products_options VALUES (10, 5, 10);
INSERT INTO products_options_values_to_products_options VALUES (13, 5, 13);

INSERT INTO products_to_categories VALUES (1,4);
INSERT INTO products_to_categories VALUES (2,4);
INSERT INTO products_to_categories VALUES (3,9);
INSERT INTO products_to_categories VALUES (4,10);
INSERT INTO products_to_categories VALUES (5,11);
INSERT INTO products_to_categories VALUES (6,10);
INSERT INTO products_to_categories VALUES (7,12);
INSERT INTO products_to_categories VALUES (8,13);
INSERT INTO products_to_categories VALUES (9,10);
INSERT INTO products_to_categories VALUES (10,10);
INSERT INTO products_to_categories VALUES (11,10);
INSERT INTO products_to_categories VALUES (12,10);
INSERT INTO products_to_categories VALUES (13,10);
INSERT INTO products_to_categories VALUES (14,15);
INSERT INTO products_to_categories VALUES (15,14);
INSERT INTO products_to_categories VALUES (16,15);
INSERT INTO products_to_categories VALUES (17,10);
INSERT INTO products_to_categories VALUES (18,10);
INSERT INTO products_to_categories VALUES (19,12);
INSERT INTO products_to_categories VALUES (20,15);
INSERT INTO products_to_categories VALUES (21,18);
INSERT INTO products_to_categories VALUES (22,19);
INSERT INTO products_to_categories VALUES (23,20);
INSERT INTO products_to_categories VALUES (24,20);
INSERT INTO products_to_categories VALUES (25,8);
INSERT INTO products_to_categories VALUES (26,9);
INSERT INTO products_to_categories VALUES (27,5);
INSERT INTO products_to_categories VALUES (28,21);

INSERT INTO reviews VALUES (1,19,0,'John Doe',5,now(),null,1,0);

INSERT INTO reviews_description VALUES (1,1, 'This has to be one of the funniest movies released for 1999!');

INSERT INTO sec_directory_whitelist values (null, 'admin/backups');
INSERT INTO sec_directory_whitelist values (null, 'admin/images/graphs');
INSERT INTO sec_directory_whitelist values (null, 'images');
INSERT INTO sec_directory_whitelist values (null, 'images/banners');
INSERT INTO sec_directory_whitelist values (null, 'images/dvd');
INSERT INTO sec_directory_whitelist values (null, 'images/gt_interactive');
INSERT INTO sec_directory_whitelist values (null, 'images/hewlett_packard');
INSERT INTO sec_directory_whitelist values (null, 'images/matrox');
INSERT INTO sec_directory_whitelist values (null, 'images/microsoft');
INSERT INTO sec_directory_whitelist values (null, 'images/samsung');
INSERT INTO sec_directory_whitelist values (null, 'images/sierra');
INSERT INTO sec_directory_whitelist values (null, 'includes/work');
INSERT INTO sec_directory_whitelist values (null, 'pub');

INSERT INTO specials VALUES (1,3, 39.99, now(), null, null, null, '1');
INSERT INTO specials VALUES (2,5, 30.00, now(), null, null, null, '1');
INSERT INTO specials VALUES (3,6, 30.00, now(), null, null, null, '1');
INSERT INTO specials VALUES (4,16, 29.99, now(), null, null, null, '1');

INSERT INTO tax_class VALUES (1, 'Taxable Goods', 'The following types of products are included non-food, services, etc', now(), now());

# USA/Florida
INSERT INTO tax_rates VALUES (1, 1, 1, 1, 7.0, 'FL TAX 7.0%', now(), now());
INSERT INTO geo_zones (geo_zone_id,geo_zone_name,geo_zone_description,date_added) VALUES (1,"Florida","Florida local sales tax zone",now());
INSERT INTO zones_to_geo_zones (association_id,zone_country_id,zone_id,geo_zone_id,date_added) VALUES (1,223,18,1,now());

# USA
INSERT INTO zones VALUES (1,223,'AL','Alabama');
INSERT INTO zones VALUES (2,223,'AK','Alaska');
INSERT INTO zones VALUES (3,223,'AS','American Samoa');
INSERT INTO zones VALUES (4,223,'AZ','Arizona');
INSERT INTO zones VALUES (5,223,'AR','Arkansas');
INSERT INTO zones VALUES (6,223,'AF','Armed Forces Africa');
INSERT INTO zones VALUES (7,223,'AA','Armed Forces Americas');
INSERT INTO zones VALUES (8,223,'AC','Armed Forces Canada');
INSERT INTO zones VALUES (9,223,'AE','Armed Forces Europe');
INSERT INTO zones VALUES (10,223,'AM','Armed Forces Middle East');
INSERT INTO zones VALUES (11,223,'AP','Armed Forces Pacific');
INSERT INTO zones VALUES (12,223,'CA','California');
INSERT INTO zones VALUES (13,223,'CO','Colorado');
INSERT INTO zones VALUES (14,223,'CT','Connecticut');
INSERT INTO zones VALUES (15,223,'DE','Delaware');
INSERT INTO zones VALUES (16,223,'DC','District of Columbia');
INSERT INTO zones VALUES (17,223,'FM','Federated States Of Micronesia');
INSERT INTO zones VALUES (18,223,'FL','Florida');
INSERT INTO zones VALUES (19,223,'GA','Georgia');
INSERT INTO zones VALUES (20,223,'GU','Guam');
INSERT INTO zones VALUES (21,223,'HI','Hawaii');
INSERT INTO zones VALUES (22,223,'ID','Idaho');
INSERT INTO zones VALUES (23,223,'IL','Illinois');
INSERT INTO zones VALUES (24,223,'IN','Indiana');
INSERT INTO zones VALUES (25,223,'IA','Iowa');
INSERT INTO zones VALUES (26,223,'KS','Kansas');
INSERT INTO zones VALUES (27,223,'KY','Kentucky');
INSERT INTO zones VALUES (28,223,'LA','Louisiana');
INSERT INTO zones VALUES (29,223,'ME','Maine');
INSERT INTO zones VALUES (30,223,'MH','Marshall Islands');
INSERT INTO zones VALUES (31,223,'MD','Maryland');
INSERT INTO zones VALUES (32,223,'MA','Massachusetts');
INSERT INTO zones VALUES (33,223,'MI','Michigan');
INSERT INTO zones VALUES (34,223,'MN','Minnesota');
INSERT INTO zones VALUES (35,223,'MS','Mississippi');
INSERT INTO zones VALUES (36,223,'MO','Missouri');
INSERT INTO zones VALUES (37,223,'MT','Montana');
INSERT INTO zones VALUES (38,223,'NE','Nebraska');
INSERT INTO zones VALUES (39,223,'NV','Nevada');
INSERT INTO zones VALUES (40,223,'NH','New Hampshire');
INSERT INTO zones VALUES (41,223,'NJ','New Jersey');
INSERT INTO zones VALUES (42,223,'NM','New Mexico');
INSERT INTO zones VALUES (43,223,'NY','New York');
INSERT INTO zones VALUES (44,223,'NC','North Carolina');
INSERT INTO zones VALUES (45,223,'ND','North Dakota');
INSERT INTO zones VALUES (46,223,'MP','Northern Mariana Islands');
INSERT INTO zones VALUES (47,223,'OH','Ohio');
INSERT INTO zones VALUES (48,223,'OK','Oklahoma');
INSERT INTO zones VALUES (49,223,'OR','Oregon');
INSERT INTO zones VALUES (50,223,'PW','Palau');
INSERT INTO zones VALUES (51,223,'PA','Pennsylvania');
INSERT INTO zones VALUES (52,223,'PR','Puerto Rico');
INSERT INTO zones VALUES (53,223,'RI','Rhode Island');
INSERT INTO zones VALUES (54,223,'SC','South Carolina');
INSERT INTO zones VALUES (55,223,'SD','South Dakota');
INSERT INTO zones VALUES (56,223,'TN','Tennessee');
INSERT INTO zones VALUES (57,223,'TX','Texas');
INSERT INTO zones VALUES (58,223,'UT','Utah');
INSERT INTO zones VALUES (59,223,'VT','Vermont');
INSERT INTO zones VALUES (60,223,'VI','Virgin Islands');
INSERT INTO zones VALUES (61,223,'VA','Virginia');
INSERT INTO zones VALUES (62,223,'WA','Washington');
INSERT INTO zones VALUES (63,223,'WV','West Virginia');
INSERT INTO zones VALUES (64,223,'WI','Wisconsin');
INSERT INTO zones VALUES (65,223,'WY','Wyoming');

# Canada
INSERT INTO zones VALUES (66,38,'AB','Alberta');
INSERT INTO zones VALUES (67,38,'BC','British Columbia');
INSERT INTO zones VALUES (68,38,'MB','Manitoba');
INSERT INTO zones VALUES (69,38,'NF','Newfoundland');
INSERT INTO zones VALUES (70,38,'NB','New Brunswick');
INSERT INTO zones VALUES (71,38,'NS','Nova Scotia');
INSERT INTO zones VALUES (72,38,'NT','Northwest Territories');
INSERT INTO zones VALUES (73,38,'NU','Nunavut');
INSERT INTO zones VALUES (74,38,'ON','Ontario');
INSERT INTO zones VALUES (75,38,'PE','Prince Edward Island');
INSERT INTO zones VALUES (76,38,'QC','Quebec');
INSERT INTO zones VALUES (77,38,'SK','Saskatchewan');
INSERT INTO zones VALUES (78,38,'YT','Yukon Territory');

# Germany
INSERT INTO zones VALUES (79,81,'NDS','Niedersachsen');
INSERT INTO zones VALUES (80,81,'BAW','Baden-Württemberg');
INSERT INTO zones VALUES (81,81,'BAY','Bayern');
INSERT INTO zones VALUES (82,81,'BER','Berlin');
INSERT INTO zones VALUES (83,81,'BRG','Brandenburg');
INSERT INTO zones VALUES (84,81,'BRE','Bremen');
INSERT INTO zones VALUES (85,81,'HAM','Hamburg');
INSERT INTO zones VALUES (86,81,'HES','Hessen');
INSERT INTO zones VALUES (87,81,'MEC','Mecklenburg-Vorpommern');
INSERT INTO zones VALUES (88,81,'NRW','Nordrhein-Westfalen');
INSERT INTO zones VALUES (89,81,'RHE','Rheinland-Pfalz');
INSERT INTO zones VALUES (90,81,'SAR','Saarland');
INSERT INTO zones VALUES (91,81,'SAS','Sachsen');
INSERT INTO zones VALUES (92,81,'SAC','Sachsen-Anhalt');
INSERT INTO zones VALUES (93,81,'SCN','Schleswig-Holstein');
INSERT INTO zones VALUES (94,81,'THE','Thüringen');

# Austria
INSERT INTO zones VALUES (95,14,'WI','Wien');
INSERT INTO zones VALUES (96,14,'NO','Niederösterreich');
INSERT INTO zones VALUES (97,14,'OO','Oberösterreich');
INSERT INTO zones VALUES (98,14,'SB','Salzburg');
INSERT INTO zones VALUES (99,14,'KN','Kärnten');
INSERT INTO zones VALUES (100,14,'ST','Steiermark');
INSERT INTO zones VALUES (101,14,'TI','Tirol');
INSERT INTO zones VALUES (102,14,'BL','Burgenland');
INSERT INTO zones VALUES (103,14,'VB','Voralberg');

# Swizterland
INSERT INTO zones VALUES (104,204,'AG','Aargau');
INSERT INTO zones VALUES (105,204,'AI','Appenzell Innerrhoden');
INSERT INTO zones VALUES (106,204,'AR','Appenzell Ausserrhoden');
INSERT INTO zones VALUES (107,204,'BE','Bern');
INSERT INTO zones VALUES (108,204,'BL','Basel-Landschaft');
INSERT INTO zones VALUES (109,204,'BS','Basel-Stadt');
INSERT INTO zones VALUES (110,204,'FR','Freiburg');
INSERT INTO zones VALUES (111,204,'GE','Genf');
INSERT INTO zones VALUES (112,204,'GL','Glarus');
INSERT INTO zones VALUES (113,204,'JU','Graubünden');
INSERT INTO zones VALUES (114,204,'JU','Jura');
INSERT INTO zones VALUES (115,204,'LU','Luzern');
INSERT INTO zones VALUES (116,204,'NE','Neuenburg');
INSERT INTO zones VALUES (117,204,'NW','Nidwalden');
INSERT INTO zones VALUES (118,204,'OW','Obwalden');
INSERT INTO zones VALUES (119,204,'SG','St. Gallen');
INSERT INTO zones VALUES (120,204,'SH','Schaffhausen');
INSERT INTO zones VALUES (121,204,'SO','Solothurn');
INSERT INTO zones VALUES (122,204,'SZ','Schwyz');
INSERT INTO zones VALUES (123,204,'TG','Thurgau');
INSERT INTO zones VALUES (124,204,'TI','Tessin');
INSERT INTO zones VALUES (125,204,'UR','Uri');
INSERT INTO zones VALUES (126,204,'VD','Waadt');
INSERT INTO zones VALUES (127,204,'VS','Wallis');
INSERT INTO zones VALUES (128,204,'ZG','Zug');
INSERT INTO zones VALUES (129,204,'ZH','Zürich');

# Spain
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'A Coruña','A Coruña');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Alava','Alava');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Albacete','Albacete');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Alicante','Alicante');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Almeria','Almeria');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Asturias','Asturias');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Avila','Avila');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Badajoz','Badajoz');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Baleares','Baleares');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Barcelona','Barcelona');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Burgos','Burgos');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Caceres','Caceres');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Cadiz','Cadiz');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Cantabria','Cantabria');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Castellon','Castellon');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Ceuta','Ceuta');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Ciudad Real','Ciudad Real');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Cordoba','Cordoba');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Cuenca','Cuenca');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Girona','Girona');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Granada','Granada');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Guadalajara','Guadalajara');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Guipuzcoa','Guipuzcoa');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Huelva','Huelva');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Huesca','Huesca');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Jaen','Jaen');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'La Rioja','La Rioja');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Las Palmas','Las Palmas');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Leon','Leon');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Lleida','Lleida');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Lugo','Lugo');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Madrid','Madrid');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Malaga','Malaga');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Melilla','Melilla');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Murcia','Murcia');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Navarra','Navarra');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Ourense','Ourense');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Palencia','Palencia');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Pontevedra','Pontevedra');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Salamanca','Salamanca');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Santa Cruz de Tenerife','Santa Cruz de Tenerife');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Segovia','Segovia');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Sevilla','Sevilla');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Soria','Soria');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Tarragona','Tarragona');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Teruel','Teruel');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Toledo','Toledo');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Valencia','Valencia');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Valladolid','Valladolid');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Vizcaya','Vizcaya');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Zamora','Zamora');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Zaragoza','Zaragoza');

# PayPal Express
INSERT INTO orders_status (orders_status_id, language_id, orders_status_name, public_flag, downloads_flag) values ('4', '1', 'PayPal [Transactions]', 0, 0);
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable PayPal Express Checkout', 'MODULE_PAYMENT_PAYPAL_EXPRESS_STATUS', 'True', 'Do you want to accept PayPal Express Checkout payments?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Seller Account', 'MODULE_PAYMENT_PAYPAL_EXPRESS_SELLER_ACCOUNT', '', 'The email address of the seller account if no API credentials has been setup.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('API Username', 'MODULE_PAYMENT_PAYPAL_EXPRESS_API_USERNAME', '', 'The username to use for the PayPal API service', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('API Password', 'MODULE_PAYMENT_PAYPAL_EXPRESS_API_PASSWORD', '', 'The password to use for the PayPal API service', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('API Signature', 'MODULE_PAYMENT_PAYPAL_EXPRESS_API_SIGNATURE', '', 'The signature to use for the PayPal API service', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('PayPal Account Optional', 'MODULE_PAYMENT_PAYPAL_EXPRESS_ACCOUNT_OPTIONAL', 'False', 'This must also be enabled in your PayPal account, in Profile > Website Payment Preferences.', '6', '0', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('PayPal Instant Update', 'MODULE_PAYMENT_PAYPAL_EXPRESS_INSTANT_UPDATE', 'True', 'Support PayPal shipping and tax calculations on the PayPal.com site during Express Checkout.', '6', '0', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('PayPal Checkout Image', 'MODULE_PAYMENT_PAYPAL_EXPRESS_CHECKOUT_IMAGE', 'Static', 'Use static or dynamic Express Checkout image buttons. Dynamic images are used with PayPal campaigns.', '6', '0', 'tep_cfg_select_option(array(\'Static\', \'Dynamic\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Page Style', 'MODULE_PAYMENT_PAYPAL_EXPRESS_PAGE_STYLE', '', 'The page style to use for the checkout flow (defined at your PayPal Profile page)', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Transaction Method', 'MODULE_PAYMENT_PAYPAL_EXPRESS_TRANSACTION_METHOD', 'Sale', 'The processing method to use for each transaction.', '6', '0', 'tep_cfg_select_option(array(\'Authorization\', \'Sale\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, use_function, date_added) values ('Set Order Status', 'MODULE_PAYMENT_PAYPAL_EXPRESS_ORDER_STATUS_ID', '0', 'Set the status of orders made with this payment module to this value', '6', '0', 'tep_cfg_pull_down_order_statuses(', 'tep_get_order_status_name', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, use_function, date_added) values ('PayPal Transactions Order Status Level', 'MODULE_PAYMENT_PAYPAL_EXPRESS_TRANSACTIONS_ORDER_STATUS_ID', '4', 'Include PayPal transaction information in this order status level', '6', '0', 'tep_cfg_pull_down_order_statuses(', 'tep_get_order_status_name', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('Payment Zone', 'MODULE_PAYMENT_PAYPAL_EXPRESS_ZONE', '0', 'If a zone is selected, only enable this payment method for that zone.', '6', '2', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Transaction Server', 'MODULE_PAYMENT_PAYPAL_EXPRESS_TRANSACTION_SERVER', 'Live', 'Use the live or testing (sandbox) gateway server to process transactions?', '6', '0', 'tep_cfg_select_option(array(\'Live\', \'Sandbox\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Verify SSL Certificate', 'MODULE_PAYMENT_PAYPAL_EXPRESS_VERIFY_SSL', 'True', 'Verify gateway server SSL certificate on connection?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Proxy Server', 'MODULE_PAYMENT_PAYPAL_EXPRESS_PROXY', '', 'Send API requests through this proxy server. (host:port, eg: 123.45.67.89:8080 or proxy.example.com:8080)', '6', '0' , now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Debug E-Mail Address', 'MODULE_PAYMENT_PAYPAL_EXPRESS_DEBUG_EMAIL', '', 'All parameters of an invalid transaction will be sent to this email address.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort order of display.', 'MODULE_PAYMENT_PAYPAL_EXPRESS_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now());

# Header Tags
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Installed Modules', 'MODULE_HEADER_TAGS_INSTALLED', 'ht_canonical.php;ht_manufacturer_title.php;ht_category_title.php;ht_product_title.php;ht_robot_noindex.php', 'List of header tag module filenames separated by a semi-colon. This is automatically updated. No need to edit.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Category Title Module', 'MODULE_HEADER_TAGS_CATEGORY_TITLE_STATUS', 'True', 'Do you want to allow category titles to be added to the page title?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_HEADER_TAGS_CATEGORY_TITLE_SORT_ORDER', '200', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Manufacturer Title Module', 'MODULE_HEADER_TAGS_MANUFACTURER_TITLE_STATUS', 'True', 'Do you want to allow manufacturer titles to be added to the page title?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_HEADER_TAGS_MANUFACTURER_TITLE_SORT_ORDER', '100', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Product Title Module', 'MODULE_HEADER_TAGS_PRODUCT_TITLE_STATUS', 'True', 'Do you want to allow product titles to be added to the page title?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_HEADER_TAGS_PRODUCT_TITLE_SORT_ORDER', '300', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Canonical Module', 'MODULE_HEADER_TAGS_CANONICAL_STATUS', 'True', 'Do you want to enable the Canonical module?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_HEADER_TAGS_CANONICAL_SORT_ORDER', '400', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Robot NoIndex Module', 'MODULE_HEADER_TAGS_ROBOT_NOINDEX_STATUS', 'True', 'Do you want to enable the Robot NoIndex module?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('Pages', 'MODULE_HEADER_TAGS_ROBOT_NOINDEX_PAGES', 'account.php;account_edit.php;account_history.php;account_history_info.php;account_newsletters.php;account_notifications.php;account_password.php;address_book.php;address_book_process.php;checkout_confirmation.php;checkout_payment.php;checkout_payment_address.php;checkout_process.php;checkout_shipping.php;checkout_shipping_address.php;checkout_success.php;cookie_usage.php;create_account.php;create_account_success.php;login.php;logoff.php;password_forgotten.php;password_reset.php;product_reviews_write.php;shopping_cart.php;ssl_check.php;tell_a_friend.php', 'The pages to add the meta robot noindex tag to.', '6', '0', 'ht_robot_noindex_show_pages', 'ht_robot_noindex_edit_pages(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_HEADER_TAGS_ROBOT_NOINDEX_SORT_ORDER', '500', 'Sort order of display. Lowest is displayed first.', '6', '0', now());

# Administration Tool Dasboard
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Installed Modules', 'MODULE_ADMIN_DASHBOARD_INSTALLED', 'd_total_revenue.php;d_total_customers.php;d_orders.php;d_customers.php;d_admin_logins.php;d_security_checks.php;d_latest_news.php;d_latest_addons.php;d_partner_news.php;d_version_check.php;d_reviews.php', 'List of Administration Tool Dashboard module filenames separated by a semi-colon. This is automatically updated. No need to edit.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Administrator Logins Module', 'MODULE_ADMIN_DASHBOARD_ADMIN_LOGINS_STATUS', 'True', 'Do you want to show the latest administrator logins on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_ADMIN_LOGINS_SORT_ORDER', '500', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Customers Module', 'MODULE_ADMIN_DASHBOARD_CUSTOMERS_STATUS', 'True', 'Do you want to show the newest customers on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_CUSTOMERS_SORT_ORDER', '400', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Latest Add-Ons Module', 'MODULE_ADMIN_DASHBOARD_LATEST_ADDONS_STATUS', 'True', 'Do you want to show the latest osCommerce Add-Ons on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_LATEST_ADDONS_SORT_ORDER', '800', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Latest News Module', 'MODULE_ADMIN_DASHBOARD_LATEST_NEWS_STATUS', 'True', 'Do you want to show the latest osCommerce News on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_LATEST_NEWS_SORT_ORDER', '700', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Orders Module', 'MODULE_ADMIN_DASHBOARD_ORDERS_STATUS', 'True', 'Do you want to show the latest orders on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_ORDERS_SORT_ORDER', '300', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Security Checks Module', 'MODULE_ADMIN_DASHBOARD_SECURITY_CHECKS_STATUS', 'True', 'Do you want to run the security checks for this installation?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_SECURITY_CHECKS_SORT_ORDER', '600', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Total Customers Module', 'MODULE_ADMIN_DASHBOARD_TOTAL_CUSTOMERS_STATUS', 'True', 'Do you want to show the total customers chart on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_TOTAL_CUSTOMERS_SORT_ORDER', '200', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Total Revenue Module', 'MODULE_ADMIN_DASHBOARD_TOTAL_REVENUE_STATUS', 'True', 'Do you want to show the total revenue chart on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_TOTAL_REVENUE_SORT_ORDER', '100', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Version Check Module', 'MODULE_ADMIN_DASHBOARD_VERSION_CHECK_STATUS', 'True', 'Do you want to show the version check results on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_VERSION_CHECK_SORT_ORDER', '900', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Latest Reviews Module', 'MODULE_ADMIN_DASHBOARD_REVIEWS_STATUS', 'True', 'Do you want to show the latest reviews on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_REVIEWS_SORT_ORDER', '1000', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Partner News Module', 'MODULE_ADMIN_DASHBOARD_PARTNER_NEWS_STATUS', 'True', 'Do you want to show the latest osCommerce Partner News on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_PARTNER_NEWS_SORT_ORDER', '820', 'Sort order of display. Lowest is displayed first.', '6', '0', now());

# Boxes
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Installed Modules', 'MODULE_BOXES_INSTALLED', 'bm_categories.php;bm_manufacturers.php;bm_search.php;bm_whats_new.php;bm_card_acceptance.php;bm_shopping_cart.php;bm_manufacturer_info.php;bm_order_history.php;bm_best_sellers.php;bm_product_notifications.php;bm_product_social_bookmarks.php;bm_specials.php;bm_reviews.php;bm_languages.php;bm_currencies.php', 'List of box module filenames separated by a semi-colon. This is automatically updated. No need to edit.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Best Sellers Module', 'MODULE_BOXES_BEST_SELLERS_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_BEST_SELLERS_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_BEST_SELLERS_SORT_ORDER', '5030', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Categories Module', 'MODULE_BOXES_CATEGORIES_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_CATEGORIES_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_CATEGORIES_SORT_ORDER', '1000', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Currencies Module', 'MODULE_BOXES_CURRENCIES_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_CURRENCIES_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_CURRENCIES_SORT_ORDER', '5090', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Languages Module', 'MODULE_BOXES_LANGUAGES_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_LANGUAGES_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_LANGUAGES_SORT_ORDER', '5080', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Manufacturer Info Module', 'MODULE_BOXES_MANUFACTURER_INFO_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_MANUFACTURER_INFO_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_MANUFACTURER_INFO_SORT_ORDER', '5010', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Manufacturers Module', 'MODULE_BOXES_MANUFACTURERS_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_MANUFACTURERS_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_MANUFACTURERS_SORT_ORDER', '1020', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Order History Module', 'MODULE_BOXES_ORDER_HISTORY_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_ORDER_HISTORY_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_ORDER_HISTORY_SORT_ORDER', '5020', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Product Notifications Module', 'MODULE_BOXES_PRODUCT_NOTIFICATIONS_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_PRODUCT_NOTIFICATIONS_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_PRODUCT_NOTIFICATIONS_SORT_ORDER', '5040', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Product Social Bookmarks Module', 'MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_SORT_ORDER', '5050', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Reviews Module', 'MODULE_BOXES_REVIEWS_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_REVIEWS_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_REVIEWS_SORT_ORDER', '5070', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Search Module', 'MODULE_BOXES_SEARCH_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_SEARCH_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_SEARCH_SORT_ORDER', '1030', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Shopping Cart Module', 'MODULE_BOXES_SHOPPING_CART_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_SHOPPING_CART_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_SHOPPING_CART_SORT_ORDER', '5000', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Specials Module', 'MODULE_BOXES_SPECIALS_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_SPECIALS_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_SPECIALS_SORT_ORDER', '5060', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable What\'s New Module', 'MODULE_BOXES_WHATS_NEW_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_WHATS_NEW_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_WHATS_NEW_SORT_ORDER', '1040', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Card Acceptance Module', 'MODULE_BOXES_CARD_ACCEPTANCE_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('Logos', 'MODULE_BOXES_CARD_ACCEPTANCE_LOGOS', 'paypal_horizontal_large.png;visa.png;mastercard_transparent.png;american_express.png;maestro_transparent.png', 'The card acceptance logos to show.', '6', '0', 'bm_card_acceptance_show_logos', 'bm_card_acceptance_edit_logos(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_CARD_ACCEPTANCE_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_CARD_ACCEPTANCE_SORT_ORDER', '1060', 'Sort order of display. Lowest is displayed first.', '6', '0', now());

# Template Block Groups
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Installed Template Block Groups', 'TEMPLATE_BLOCK_GROUPS', 'boxes;header_tags', 'This is automatically updated. No need to edit.', '6', '0', now());

# Content Modules
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Installed Modules', 'MODULE_CONTENT_INSTALLED', 'account/cm_account_set_password;checkout_success/cm_cs_redirect_old_order;checkout_success/cm_cs_thank_you;checkout_success/cm_cs_product_notifications;checkout_success/cm_cs_downloads;login/cm_login_form;login/cm_create_account_link;navigation/cm_navbar;header/cm_header_logo;header/cm_header_buttons;header/cm_header_breadcrumb;header/cm_header_messagestack;footer/cm_footer_information_links;footer_suffix/cm_footer_extra_copyright;footer_suffix/cm_footer_extra_icons', 'This is automatically updated. No need to edit.', '6', '0', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Set Account Password', 'MODULE_CONTENT_ACCOUNT_SET_PASSWORD_STATUS', 'True', 'Do you want to enable the Set Account Password module?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Allow Local Passwords', 'MODULE_CONTENT_ACCOUNT_SET_PASSWORD_ALLOW_PASSWORD', 'True', 'Allow local account passwords to be set.', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_ACCOUNT_SET_PASSWORD_SORT_ORDER', '100', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Redirect Old Order Module', 'MODULE_CONTENT_CHECKOUT_SUCCESS_REDIRECT_OLD_ORDER_STATUS', 'True', 'Should customers be redirected when viewing old checkout success orders?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Redirect Minutes', 'MODULE_CONTENT_CHECKOUT_SUCCESS_REDIRECT_OLD_ORDER_MINUTES', '60', 'Redirect customers to the My Account page after an order older than this amount is viewed.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_CHECKOUT_SUCCESS_REDIRECT_OLD_ORDER_SORT_ORDER', '500', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Thank You Module', 'MODULE_CONTENT_CHECKOUT_SUCCESS_THANK_YOU_STATUS', 'True', 'Should the thank you block be shown on the checkout success page?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_CHECKOUT_SUCCESS_THANK_YOU_SORT_ORDER', '1000', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Product Notifications Module', 'MODULE_CONTENT_CHECKOUT_SUCCESS_PRODUCT_NOTIFICATIONS_STATUS', 'True', 'Should the product notifications block be shown on the checkout success page?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_CHECKOUT_SUCCESS_PRODUCT_NOTIFICATIONS_SORT_ORDER', '2000', 'Sort order of display. Lowest is displayed first.', '6', '3', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Product Downloads Module', 'MODULE_CONTENT_CHECKOUT_SUCCESS_DOWNLOADS_STATUS', 'True', 'Should ordered product download links be shown on the checkout success page?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_CHECKOUT_SUCCESS_DOWNLOADS_SORT_ORDER', '3000', 'Sort order of display. Lowest is displayed first.', '6', '3', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Login Form Module', 'MODULE_CONTENT_LOGIN_FORM_STATUS', 'True', 'Do you want to enable the login form module?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Width', 'MODULE_CONTENT_LOGIN_FORM_CONTENT_WIDTH', 'Half', 'Should the content be shown in a full or half width container?', '6', '1', 'tep_cfg_select_option(array(\'Full\', \'Half\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_LOGIN_FORM_SORT_ORDER', '1000', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable New User Module', 'MODULE_CONTENT_CREATE_ACCOUNT_LINK_STATUS', 'True', 'Do you want to enable the new user module?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Width', 'MODULE_CONTENT_CREATE_ACCOUNT_LINK_CONTENT_WIDTH', 'Half', 'Should the content be shown in a full or half width container?', '6', '1', 'tep_cfg_select_option(array(\'Full\', \'Half\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_CREATE_ACCOUNT_LINK_SORT_ORDER', '2000', 'Sort order of display. Lowest is displayed first.', '6', '0', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Navbar Module', 'MODULE_CONTENT_NAVBAR_STATUS', 'True', 'Should the Navbar be shown? ', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_NAVBAR_SORT_ORDER', '10', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Header Logo Module', 'MODULE_CONTENT_HEADER_LOGO_STATUS', 'True', 'Do you want to enable the Logo content module?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Width', 'MODULE_CONTENT_HEADER_LOGO_CONTENT_WIDTH', '6', 'What width container should the content be shown in?', '6', '1', 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_HEADER_LOGO_SORT_ORDER', '10', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Header Buttons Module', 'MODULE_CONTENT_HEADER_BUTTONS_STATUS', 'True', 'Do you want to enable the Buttons content module?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Width', 'MODULE_CONTENT_HEADER_BUTTONS_CONTENT_WIDTH', '6', 'What width container should the content be shown in?', '6', '1', 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_HEADER_BUTTONS_SORT_ORDER', '20', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Header Breadcrumb Module', 'MODULE_CONTENT_HEADER_BREADCRUMB_STATUS', 'True', 'Do you want to enable the Breadcrumb content module?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Width', 'MODULE_CONTENT_HEADER_BREADCRUMB_CONTENT_WIDTH', '12', 'What width container should the content be shown in?', '6', '1', 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_HEADER_BREADCRUMB_SORT_ORDER', '30', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Message Stack Notifications Module', 'MODULE_CONTENT_HEADER_MESSAGESTACK_STATUS', 'True', 'Should the Message Stack Notifications be shown in the header when needed? ', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_HEADER_MESSAGESTACK_SORT_ORDER', '40', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Information Links Footer Module', 'MODULE_CONTENT_FOOTER_INFORMATION_STATUS', 'True', 'Do you want to enable the Information Links content module?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Width', 'MODULE_CONTENT_FOOTER_INFORMATION_CONTENT_WIDTH', '3', 'What width container should the content be shown in? (12 = full width, 6 = half width).', '6', '1', 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_FOOTER_INFORMATION_SORT_ORDER', '10', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Contact Us Footer Module', 'MODULE_CONTENT_FOOTER_EXTRA_COPYRIGHT_STATUS', 'True', 'Do you want to enable the Copyright content module?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Width', 'MODULE_CONTENT_FOOTER_EXTRA_COPYRIGHT_CONTENT_WIDTH', '6', 'What width container should the content be shown in? (12 = full width, 6 = half width).', '6', '1', 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_FOOTER_EXTRA_COPYRIGHT_SORT_ORDER', '10', 'Sort order of display. Lowest is displayed first.', '6', '1', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Contact Us Footer Module', 'MODULE_CONTENT_FOOTER_EXTRA_ICONS_STATUS', 'True', 'Do you want to enable the Payment Icons content module?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Width', 'MODULE_CONTENT_FOOTER_EXTRA_ICONS_CONTENT_WIDTH', '6', 'What width container should the content be shown in? (12 = full width, 6 = half width).', '6', '1', 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_FOOTER_EXTRA_ICONS_SORT_ORDER', '20', 'Sort order of display. Lowest is displayed first.', '6', '1', now());


INSERT INTO osc_languages (languages_id, name, code, locale, charset, date_format_short, date_format_long, time_format, text_direction, currencies_id, numeric_separator_decimal, numeric_separator_thousands, parent_id, sort_order) VALUES (1, 'English', 'en_US', 'en_US.UTF-8,en_US,english', 'utf-8', '%m/%d/%Y', '%A %d %B, %Y', '%H:%M:%S', 'ltr', 1, '.', ',', 0, 1);

INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(392, 1, 'general', 'CHECKOUT_SUCCESS_TABLE_HEADING_COMMENTS', 'Enter a comment for the order processed');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(393, 1, 'general', 'CONDITIONS_NAVBAR_TITLE', 'Conditions of Use');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(394, 1, 'general', 'CONDITIONS_HEADING_TITLE', 'Conditions of Use');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(395, 1, 'general', 'CONDITIONS_TEXT_INFORMATION', 'Put here your Conditions of Use information.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(396, 1, 'general', 'CONTACT_US_HEADING_TITLE', 'Contact Us');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(397, 1, 'general', 'CONTACT_US_NAVBAR_TITLE', 'Contact Us');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(398, 1, 'general', 'CONTACT_US_TEXT_SUCCESS', 'Your enquiry has been successfully sent to the Store Owner.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(399, 1, 'general', 'CONTACT_US_EMAIL_SUBJECT', 'Enquiry from ');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(400, 1, 'general', 'CONTACT_US_ENTRY_NAME', 'Full Name');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(401, 1, 'general', 'CONTACT_US_ENTRY_EMAIL', 'E-Mail Address');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(402, 1, 'general', 'CONTACT_US_ENTRY_ENQUIRY', 'Enquiry');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(403, 1, 'general', 'CONTACT_US_ERROR_ACTION_RECORDER', 'Error: An enquiry has already been sent. Please try again in %s minutes.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(404, 1, 'general', 'COOKIE_USAGE_NAVBAR_TITLE', 'Cookie Usage');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(405, 1, 'general', 'COOKIE_USAGE_HEADING_TITLE', 'Cookie Usage');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(406, 1, 'general', 'COOKIE_USAGE_TEXT_INFORMATION', 'We have detected that your browser does not support cookies, or has set cookies to be disabled.<br /><br />To continue shopping online, we encourage you to enable cookies on your browser.<br /><br />For <strong>Internet Explorer</strong> browsers, please follow these instructions:<br /><ol><li>Click on the Tools menubar, and select Internet Options</li><li>Select the Security tab, and reset the security level to Medium</li></ol>We have taken this measurement of security for your benefit, and apologize upfront if any inconveniences are caused.<br /><br />Please contact the store owner if you have any questions relating to this requirement, or to continue purchasing products offline.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(407, 1, 'general', 'COOKIE_USAGE_BOX_INFORMATION_HEADING', 'Cookie Privacy and Security');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(408, 1, 'general', 'COOKIE_USAGE_BOX_INFORMATION', 'Cookies must be enabled to purchase online on this store to embrace privacy and security related issues regarding your visit to this site.<br /><br />By enabling cookie support on your browser, the communication between you and this site is strengthened to be certain it is you who are making transactions on your own behalf, and to prevent leakage of your privacy information.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(409, 1, 'general', 'CREATE_ACCOUNT_NAVBAR_TITLE', 'Create an Account');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(410, 1, 'general', 'CREATE_ACCOUNT_HEADING_TITLE', 'My Account Information');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(411, 1, 'general', 'CREATE_ACCOUNT_TEXT_ORIGIN_LOGIN', '<font color="#FF0000"><small><strong>NOTE:</strong></small></font> If you already have an account with us, please login at the <a href="%s"><u>login page</u></a>.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(412, 1, 'general', 'CREATE_ACCOUNT_EMAIL_SUBJECT', 'Welcome to ');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(413, 1, 'general', 'CREATE_ACCOUNT_EMAIL_GREET_MR', 'Dear Mr. %s,');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(414, 1, 'general', 'CREATE_ACCOUNT_EMAIL_GREET_MS', 'Dear Ms. %s,');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(415, 1, 'general', 'CREATE_ACCOUNT_EMAIL_GREET_NONE', 'Dear %s');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(416, 1, 'general', 'CREATE_ACCOUNT_EMAIL_WELCOME', 'We welcome you to <strong>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(417, 1, 'general', 'CREATE_ACCOUNT_EMAIL_TEXT', 'You can now take part in the <strong>various services</strong> we have to offer you. Some of these services include:');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(418, 1, 'general', 'CREATE_ACCOUNT_EMAIL_CONTACT', 'For help with any of our online services, please email the store-owner: ');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(419, 1, 'general', 'CREATE_ACCOUNT_EMAIL_WARNING', '<strong>Note:</strong> This email address was given to us by one of our customers. If you did not signup to be a member, please send an email to ');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(420, 1, 'general', 'CREATE_ACCOUNT_SUCCESS_NAVBAR_TITLE_1', 'Create an Account');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(421, 1, 'general', 'CREATE_ACCOUNT_SUCCESS_NAVBAR_TITLE_2', 'Success');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(422, 1, 'general', 'CREATE_ACCOUNT_SUCCESS_HEADING_TITLE', 'Your Account Has Been Created!');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(423, 1, 'general', 'CREATE_ACCOUNT_SUCCESS_TEXT_ACCOUNT_CREATED', 'Congratulations! Your new account has been successfully created! You can now take advantage of member priviledges to enhance your online shopping experience with us. If you have <small><strong>ANY</strong></small> questions about the operation of this online shop, please email the <a href="');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(424, 1, 'general', 'INDEX_TEXT_MAIN', '');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(425, 1, 'general', 'INDEX_TABLE_HEADING_NEW_PRODUCTS', 'New Products For %s');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(426, 1, 'general', 'INDEX_TABLE_HEADING_UPCOMING_PRODUCTS', 'Upcoming Products');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(427, 1, 'general', 'INDEX_TABLE_HEADING_DATE_EXPECTED', 'Date Expected');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(428, 1, 'general', 'INDEX_HEADING_TITLE', 'Welcome to ');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(429, 1, 'general', 'INDEX_TABLE_HEADING_IMAGE', '');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(430, 1, 'general', 'INDEX_TABLE_HEADING_MODEL', 'Model');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(431, 1, 'general', 'INDEX_TABLE_HEADING_PRODUCTS', 'Product Name');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(432, 1, 'general', 'INDEX_TABLE_HEADING_MANUFACTURER', 'Manufacturer');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(433, 1, 'general', 'INDEX_TABLE_HEADING_QUANTITY', 'Quantity');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(434, 1, 'general', 'INDEX_TABLE_HEADING_PRICE', 'Price');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(435, 1, 'general', 'INDEX_TABLE_HEADING_WEIGHT', 'Weight');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(436, 1, 'general', 'INDEX_TABLE_HEADING_BUY_NOW', 'Buy Now');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(437, 1, 'general', 'INDEX_TEXT_NO_PRODUCTS', 'There are no products available in this category.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(438, 1, 'general', 'INDEX_TEXT_NUMBER_OF_PRODUCTS', 'Number of Products: ');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(439, 1, 'general', 'INDEX_TEXT_SHOW', '<strong>Show:</strong>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(440, 1, 'general', 'INDEX_TEXT_BUY', 'Buy 1 \\''');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(441, 1, 'general', 'INDEX_TEXT_NOW', '\\'' now');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(442, 1, 'general', 'INDEX_TEXT_ALL_CATEGORIES', 'All Categories');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(443, 1, 'general', 'INDEX_TEXT_ALL_MANUFACTURERS', 'All Manufacturers');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(444, 1, 'general', 'INFO_SHOPPING_CART_HEADING_TITLE', 'Visitors Cart / Members Cart');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(445, 1, 'general', 'INFO_SHOPPING_CART_SUB_HEADING_TITLE_1', 'Visitors Cart');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(446, 1, 'general', 'INFO_SHOPPING_CART_SUB_HEADING_TITLE_2', 'Members Cart');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(447, 1, 'general', 'INFO_SHOPPING_CART_SUB_HEADING_TITLE_3', 'Info');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(448, 1, 'general', 'INFO_SHOPPING_CART_SUB_HEADING_TEXT_1', 'Every visitor to our online shop will be given a \\''Visitors Cart\\''. This allows the visitor to store their products in a temporary shopping cart. Once the visitor leaves the online shop, so will the contents of their shopping cart.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(449, 1, 'general', 'INFO_SHOPPING_CART_SUB_HEADING_TEXT_2', 'Every member to our online shop that logs in is given a \\''Members Cart\\''. This allows the member to add products to their shopping cart, and come back at a later date to finalize their checkout. All products remain in their shopping cart until the member has  checked them out, or removed the products themselves.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(450, 1, 'general', 'INFO_SHOPPING_CART_SUB_HEADING_TEXT_3', 'If a member adds products to their \\''Visitors Cart\\'' and decides to log in to the online shop to use their \\''Members Cart\\'', the contents of their \\''Visitors Cart\\'' will merge with their \\''Members Cart\\'' contents automatically.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(451, 1, 'general', 'INFO_SHOPPING_CART_TEXT_CLOSE_WINDOW', '[ close window ]');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(452, 1, 'general', 'LOGIN_NAVBAR_TITLE', 'Login');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(453, 1, 'general', 'LOGIN_HEADING_TITLE', 'Welcome, Please Sign In');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(454, 1, 'general', 'LOGOFF_HEADING_TITLE', 'Log Off');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(455, 1, 'general', 'LOGOFF_NAVBAR_TITLE', 'Log Off');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(456, 1, 'general', 'LOGOFF_TEXT_MAIN', 'You have been logged off your account. It is now safe to leave the computer.<br /><br />Your shopping cart has been saved, the items inside it will be restored whenever you log back into your account.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(457, 1, 'general', 'PASSWORD_FORGOTTEN_NAVBAR_TITLE_1', 'Login');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(458, 1, 'general', 'PASSWORD_FORGOTTEN_NAVBAR_TITLE_2', 'Password Forgotten');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(459, 1, 'general', 'PASSWORD_FORGOTTEN_HEADING_TITLE', 'I\\''ve Forgotten My Password!');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(460, 1, 'general', 'PASSWORD_FORGOTTEN_TEXT_MAIN', 'If you\\''ve forgotten your password, enter your e-mail address below and we\\''ll send you instructions on how to securely change your password.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(461, 1, 'general', 'PASSWORD_FORGOTTEN_TEXT_PASSWORD_RESET_INITIATED', 'Please check your e-mail for instructions on how to change your password. The instructions contain a link that is valid only for 24 hours or until your password has been updated.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(462, 1, 'general', 'PASSWORD_FORGOTTEN_TEXT_NO_EMAIL_ADDRESS_FOUND', 'Error: The E-Mail Address was not found in our records, please try again.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(463, 1, 'general', 'PASSWORD_FORGOTTEN_EMAIL_PASSWORD_RESET_SUBJECT', 'STORE_NAME');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(464, 1, 'general', 'PASSWORD_FORGOTTEN_EMAIL_PASSWORD_RESET_BODY', 'A new password has been requested for your account at ');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(465, 1, 'general', 'PASSWORD_FORGOTTEN_ERROR_ACTION_RECORDER', 'Error: A password reset link has already been sent. Please try again in %s minutes.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(466, 1, 'general', 'PASSWORD_RESET_NAVBAR_TITLE_1', 'Login');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(467, 1, 'general', 'PASSWORD_RESET_NAVBAR_TITLE_2', 'Password Reset');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(468, 1, 'general', 'PASSWORD_RESET_HEADING_TITLE', 'Password Reset');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(469, 1, 'general', 'PASSWORD_RESET_TEXT_MAIN', 'Please enter a new password for your account.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(470, 1, 'general', 'PASSWORD_RESET_TEXT_NO_RESET_LINK_FOUND', 'Error: The password reset link was not found in our records, please try again by generating a new link.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(471, 1, 'general', 'PASSWORD_RESET_TEXT_NO_EMAIL_ADDRESS_FOUND', 'Error: The E-Mail Address was not found in our records, please try again.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(472, 1, 'general', 'PASSWORD_RESET_SUCCESS_PASSWORD_RESET', 'Your password has been successfully updated. Please login with your new password.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(473, 1, 'general', 'PRIVACY_NAVBAR_TITLE', 'Privacy Notice');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(474, 1, 'general', 'PRIVACY_HEADING_TITLE', 'Privacy Notice');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(475, 1, 'general', 'PRIVACY_TEXT_INFORMATION', 'Put here your Privacy Notice information.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(476, 1, 'general', 'PRODUCT_INFO_TEXT_PRODUCT_NOT_FOUND', 'Product not found!');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(477, 1, 'general', 'PRODUCT_INFO_TEXT_CURRENT_REVIEWS', 'Current Reviews');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(478, 1, 'general', 'PRODUCT_INFO_TEXT_MORE_INFORMATION', 'For more information, please visit this products <a href="%s" target="_blank"><u>webpage</u></a>.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(479, 1, 'general', 'PRODUCT_INFO_TEXT_DATE_ADDED', 'This product was added to our catalog on %s.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(480, 1, 'general', 'PRODUCT_INFO_TEXT_DATE_AVAILABLE', '<font color="#ff0000">This product will be in stock on %s.</font>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(481, 1, 'general', 'PRODUCT_INFO_TEXT_ALSO_PURCHASED_PRODUCTS', 'Customers who bought this product also purchased');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(482, 1, 'general', 'PRODUCT_INFO_TEXT_PRODUCT_OPTIONS', 'Available Options');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(483, 1, 'general', 'PRODUCT_INFO_TEXT_CLICK_TO_ENLARGE', 'Click to enlarge');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(484, 1, 'general', 'PRODUCT_REVIEWS_NAVBAR_TITLE', 'Reviews');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(485, 1, 'general', 'PRODUCT_REVIEWS_TEXT_CLICK_TO_ENLARGE', 'Click to enlarge');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(486, 1, 'general', 'PRODUCT_REVIEWS_TEXT_OF_5_STARS', '%s of 5 Stars!');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(487, 1, 'general', 'PRODUCT_REVIEWS_WRITE_NAVBAR_TITLE', 'Reviews');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(488, 1, 'general', 'PRODUCT_REVIEWS_WRITE_SUB_TITLE_FROM', 'From');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(489, 1, 'general', 'PRODUCT_REVIEWS_WRITE_SUB_TITLE_REVIEW', 'Your Review');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(490, 1, 'general', 'PRODUCT_REVIEWS_WRITE_SUB_TITLE_RATING', 'Rating');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(491, 1, 'general', 'PRODUCT_REVIEWS_WRITE_TEXT_NO_HTML', '<small><font color="#ff0000"><strong>NOTE:</strong></font></small>&nbsp;HTML is not translated!');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(492, 1, 'general', 'PRODUCT_REVIEWS_WRITE_TEXT_BAD', '<small><font color="#ff0000"><strong>BAD</strong></font></small>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(493, 1, 'general', 'PRODUCT_REVIEWS_WRITE_TEXT_GOOD', '<small><font color="#ff0000"><strong>GOOD</strong></font></small>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(494, 1, 'general', 'PRODUCT_REVIEWS_WRITE_TEXT_REVIEW_RECEIVED', 'Thank you for your review. It has been submitted to the store owner for approval and should appear shortly.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(495, 1, 'general', 'PRODUCT_REVIEWS_WRITE_TEXT_CLICK_TO_ENLARGE', 'Click to enlarge');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(496, 1, 'general', 'PRODUCTS_NEW_NAVBAR_TITLE', 'New Products');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(497, 1, 'general', 'PRODUCTS_NEW_HEADING_TITLE', 'New Products');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(498, 1, 'general', 'PRODUCTS_NEW_TEXT_DATE_ADDED', 'Date Added');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(499, 1, 'general', 'PRODUCTS_NEW_TEXT_MANUFACTURER', 'Manufacturer');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(500, 1, 'general', 'PRODUCTS_NEW_TEXT_PRICE', 'Price');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(501, 1, 'general', 'REVIEWS_NAVBAR_TITLE', 'Reviews');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(502, 1, 'general', 'REVIEWS_HEADING_TITLE', 'Read What Others Are Saying');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(503, 1, 'general', 'REVIEWS_TEXT_OF_5_STARS', '%s of 5 Stars!');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(504, 1, 'general', 'REVIEWS_REVIEWS_TEXT_READ_MORE', 'Read More');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(505, 1, 'general', 'SHIPPING_NAVBAR_TITLE', 'Shipping &amp; Returns');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(506, 1, 'general', 'SHIPPING_HEADING_TITLE', 'Shipping &amp; Returns');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(507, 1, 'general', 'SHIPPING_TEXT_INFORMATION', 'Put here your Shipping &amp; Returns information.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(508, 1, 'general', 'SHOPPING_CART_NAVBAR_TITLE', 'Cart Contents');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(509, 1, 'general', 'SHOPPING_CART_HEADING_TITLE', 'What\\''s In My Cart?');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(510, 1, 'general', 'SHOPPING_CART_TABLE_HEADING_PRODUCTS', 'Product(s)');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(511, 1, 'general', 'SHOPPING_CART_TEXT_CART_EMPTY', 'Your Shopping Cart is empty!');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(512, 1, 'general', 'SHOPPING_CART_SUB_TITLE_SUB_TOTAL', 'Sub-Total');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(513, 1, 'general', 'SHOPPING_CART_SUB_TITLE_TOTAL', 'Total');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(514, 1, 'general', 'SHOPPING_CART_OUT_OF_STOCK_CANT_CHECKOUT', 'Products marked with ');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(515, 1, 'general', 'SHOPPING_CART_OUT_OF_STOCK_CAN_CHECKOUT', 'Products marked with ');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(516, 1, 'general', 'SHOPPING_CART_TEXT_ALTERNATIVE_CHECKOUT_METHODS', '- OR -');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(517, 1, 'general', 'SHOPPING_CART_TEXT_OR', 'or ');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(518, 1, 'general', 'SHOPPING_CART_TEXT_REMOVE', 'remove');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(519, 1, 'general', 'SPECIALS_NAVBAR_TITLE', 'Specials');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(520, 1, 'general', 'SPECIALS_HEADING_TITLE', 'Get Them While They\\''re Hot!');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(521, 1, 'general', 'SSL_CHECK_NAVBAR_TITLE', 'Security Check');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(522, 1, 'general', 'SSL_CHECK_HEADING_TITLE', 'Security Check');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(523, 1, 'general', 'SSL_CHECK_TEXT_INFORMATION', 'We have detected that your browser has generated a different SSL Session ID used throughout our secure pages.<br /><br />For security measures you will need to logon to your account again to continue shopping online.<br /><br />Some browsers such as Konqueror 3.1 does not have the capability of generating a secure SSL Session ID automatically which we require. If you use such a browser, we recommend switching to another browser such as <a href="http://www.microsoft.com/ie/" target="_blank">Microsoft Internet Explorer</a>, <a href="http://channels.netscape.com/ns/browsers/download_other.jsp" target="_blank">Netscape</a>, or <a href="http://www.mozilla.org/releases/" target="_blank">Mozilla</a>, to continue your online shopping experience.<br /><br />We have taken this measurement of security for your benefit, and apologize upfront if any inconveniences are caused.<br /><br />Please contact the store owner if you have any questions relating to this requirement, or to continue purchasing products offline.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(524, 1, 'general', 'SSL_CHECK_BOX_INFORMATION_HEADING', 'Privacy and Security');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(525, 1, 'general', 'SSL_CHECK_BOX_INFORMATION', 'We validate the SSL Session ID automatically generated by your browser on every secure page request made to this server.<br /><br />This validation assures that it is you who is navigating on this site with your account and not somebody else.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(526, 1, 'general', 'TELL_A_FRIEND_NAVBAR_TITLE', 'Tell A Friend');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(527, 1, 'general', 'TELL_A_FRIEND_HEADING_TITLE', 'Tell A Friend About ''%s''');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(528, 1, 'general', 'TELL_A_FRIEND_FORM_TITLE_CUSTOMER_DETAILS', 'Your Details');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(529, 1, 'general', 'TELL_A_FRIEND_FORM_TITLE_FRIEND_DETAILS', 'Your Friends Details');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(530, 1, 'general', 'TELL_A_FRIEND_FORM_TITLE_FRIEND_MESSAGE', 'Your Message');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(531, 1, 'general', 'TELL_A_FRIEND_FORM_FIELD_CUSTOMER_NAME', 'Your Name');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(532, 1, 'general', 'TELL_A_FRIEND_FORM_FIELD_CUSTOMER_EMAIL', 'Your E-Mail Address');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(533, 1, 'general', 'TELL_A_FRIEND_FORM_FIELD_FRIEND_NAME', 'Your Friends Name');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(534, 1, 'general', 'TELL_A_FRIEND_FORM_FIELD_FRIEND_EMAIL', 'Your Friends E-Mail Address');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(535, 1, 'general', 'TELL_A_FRIEND_TEXT_EMAIL_SUCCESSFUL_SENT', 'Your email about <strong>%s</strong> has been successfully sent to <strong>%s</strong>.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(536, 1, 'general', 'TELL_A_FRIEND_TEXT_EMAIL_SUBJECT', 'Your friend %s has recommended this great product from %s');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(537, 1, 'general', 'TELL_A_FRIEND_TEXT_EMAIL_INTRO', 'Hi %s!');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(538, 1, 'general', 'TELL_A_FRIEND_TEXT_EMAIL_LINK', 'To view the product click on the link below or copy and paste the link into your web browser:');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(539, 1, 'general', 'TELL_A_FRIEND_TEXT_EMAIL_SIGNATURE', 'Regards,');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(540, 1, 'general', 'TELL_A_FRIEND_ERROR_TO_NAME', 'Error: Your friends name must not be empty.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(541, 1, 'general', 'TELL_A_FRIEND_ERROR_TO_ADDRESS', 'Error: Your friends e-mail address must be a valid e-mail address.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(542, 1, 'general', 'TELL_A_FRIEND_ERROR_FROM_NAME', 'Error: Your name must not be empty.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(543, 1, 'general', 'TELL_A_FRIEND_ERROR_FROM_ADDRESS', 'Error: Your e-mail address must be a valid e-mail address.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(544, 1, 'general', 'TELL_A_FRIEND_ERROR_ACTION_RECORDER', 'Error: An e-mail has already been sent. Please try again in %s minutes.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(545, 1, 'modules-boxes', 'MODULE_BOXES_BEST_SELLERS_TITLE', 'Best Sellers');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(546, 1, 'modules-boxes', 'MODULE_BOXES_BEST_SELLERS_DESCRIPTION', 'Show global and category best sellers');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(547, 1, 'modules-boxes', 'MODULE_BOXES_BEST_SELLERS_BOX_TITLE', 'Bestsellers');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(548, 1, 'modules-boxes', 'MODULE_BOXES_CARD_ACCEPTANCE_TITLE', 'Card Acceptance');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(549, 1, 'modules-boxes', 'MODULE_BOXES_CARD_ACCEPTANCE_DESCRIPTION', 'Show payment card acceptance logos');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(550, 1, 'modules-boxes', 'MODULE_BOXES_CARD_ACCEPTANCE_SHOWN_CARDS', 'Shown Cards');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(551, 1, 'modules-boxes', 'MODULE_BOXES_CARD_ACCEPTANCE_NEW_CARDS', 'New Cards');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(552, 1, 'modules-boxes', 'MODULE_BOXES_CARD_ACCEPTANCE_DRAG_HERE', 'Drag Here');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(553, 1, 'modules-boxes', 'MODULE_BOXES_CARD_ACCEPTANCE_BOX_TITLE', 'We Accept');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(554, 1, 'modules-boxes', 'MODULE_BOXES_CATEGORIES_TITLE', 'Categories');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(555, 1, 'modules-boxes', 'MODULE_BOXES_CATEGORIES_DESCRIPTION', 'Show the category navigation tree');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(556, 1, 'modules-boxes', 'MODULE_BOXES_CATEGORIES_BOX_TITLE', 'Categories');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(557, 1, 'modules-boxes', 'MODULE_BOXES_CURRENCIES_TITLE', 'Currencies');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(558, 1, 'modules-boxes', 'MODULE_BOXES_CURRENCIES_DESCRIPTION', 'Show available currencies');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(559, 1, 'modules-boxes', 'MODULE_BOXES_CURRENCIES_BOX_TITLE', 'Currencies');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(560, 1, 'modules-boxes', 'MODULE_BOXES_INFORMATION_TITLE', 'Information');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(561, 1, 'modules-boxes', 'MODULE_BOXES_INFORMATION_DESCRIPTION', 'Show information page links');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(562, 1, 'modules-boxes', 'MODULE_BOXES_INFORMATION_BOX_TITLE', 'Information');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(563, 1, 'modules-boxes', 'MODULE_BOXES_INFORMATION_BOX_PRIVACY', 'Privacy Notice');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(564, 1, 'modules-boxes', 'MODULE_BOXES_INFORMATION_BOX_CONDITIONS', 'Conditions of Use');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(565, 1, 'modules-boxes', 'MODULE_BOXES_INFORMATION_BOX_SHIPPING', 'Shipping &amp; Returns');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(566, 1, 'modules-boxes', 'MODULE_BOXES_INFORMATION_BOX_CONTACT', 'Contact Us');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(567, 1, 'modules-boxes', 'MODULE_BOXES_LANGUAGES_TITLE', 'Languages');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(568, 1, 'modules-boxes', 'MODULE_BOXES_LANGUAGES_DESCRIPTION', 'Show available languages');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(569, 1, 'modules-boxes', 'MODULE_BOXES_LANGUAGES_BOX_TITLE', 'Languages');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(570, 1, 'modules-boxes', 'MODULE_BOXES_MANUFACTURER_INFO_TITLE', 'Manufacturer Info');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(571, 1, 'modules-boxes', 'MODULE_BOXES_MANUFACTURER_INFO_DESCRIPTION', 'Show manufacturer information on the product information page');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(572, 1, 'modules-boxes', 'MODULE_BOXES_MANUFACTURER_INFO_BOX_TITLE', 'Manufacturer Info');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(573, 1, 'modules-boxes', 'MODULE_BOXES_MANUFACTURER_INFO_BOX_HOMEPAGE', '%s Homepage');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(574, 1, 'modules-boxes', 'MODULE_BOXES_MANUFACTURER_INFO_BOX_OTHER_PRODUCTS', 'Other products');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(575, 1, 'modules-boxes', 'MODULE_BOXES_MANUFACTURERS_TITLE', 'Manufacturers');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(576, 1, 'modules-boxes', 'MODULE_BOXES_MANUFACTURERS_DESCRIPTION', 'Show a list of manufacturers');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(577, 1, 'modules-boxes', 'MODULE_BOXES_MANUFACTURERS_BOX_TITLE', 'Manufacturers');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(578, 1, 'modules-boxes', 'MODULE_BOXES_ORDER_HISTORY_TITLE', 'Order History');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(579, 1, 'modules-boxes', 'MODULE_BOXES_ORDER_HISTORY_DESCRIPTION', 'Show previously ordered products to signed in customers');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(580, 1, 'modules-boxes', 'MODULE_BOXES_ORDER_HISTORY_BOX_TITLE', 'Order History');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(581, 1, 'modules-boxes', 'MODULE_BOXES_PRODUCT_NOTIFICATIONS_TITLE', 'Product Notifications');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(582, 1, 'modules-boxes', 'MODULE_BOXES_PRODUCT_NOTIFICATIONS_DESCRIPTION', 'Show product notifications on the product information page');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(583, 1, 'modules-boxes', 'MODULE_BOXES_PRODUCT_NOTIFICATIONS_BOX_TITLE', 'Notifications');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(584, 1, 'modules-boxes', 'MODULE_BOXES_PRODUCT_NOTIFICATIONS_BOX_NOTIFY', 'Notify me of updates to <strong>%s</strong>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(585, 1, 'modules-boxes', 'MODULE_BOXES_PRODUCT_NOTIFICATIONS_BOX_NOTIFY_REMOVE', 'Do not notify me of updates to <strong>%s</strong>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(586, 1, 'modules-boxes', 'MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_TITLE', 'Product Social Bookmarks');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(587, 1, 'modules-boxes', 'MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_DESCRIPTION', 'Show social bookmarks on the product information page');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(588, 1, 'modules-boxes', 'MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_BOX_TITLE', 'Share Product');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(589, 1, 'modules-boxes', 'MODULE_BOXES_REVIEWS_TITLE', 'Reviews');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(590, 1, 'modules-boxes', 'MODULE_BOXES_REVIEWS_DESCRIPTION', 'Show product reviews');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(591, 1, 'modules-boxes', 'MODULE_BOXES_REVIEWS_BOX_TITLE', 'Reviews');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(592, 1, 'modules-boxes', 'MODULE_BOXES_REVIEWS_BOX_WRITE_REVIEW', 'Write a review on this product!');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(593, 1, 'modules-boxes', 'MODULE_BOXES_REVIEWS_BOX_NO_REVIEWS', 'There are currently no product reviews');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(594, 1, 'modules-boxes', 'MODULE_BOXES_REVIEWS_BOX_TEXT_OF_5_STARS', '%s of 5 Stars!');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(595, 1, 'modules-boxes', 'MODULE_BOXES_SEARCH_TITLE', 'Search');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(596, 1, 'modules-boxes', 'MODULE_BOXES_SEARCH_DESCRIPTION', 'Show search field');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(597, 1, 'modules-boxes', 'MODULE_BOXES_SEARCH_BOX_TITLE', 'Quick Find');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(598, 1, 'modules-boxes', 'MODULE_BOXES_SEARCH_BOX_ADVANCED_SEARCH', 'Advanced Search');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(599, 1, 'modules-boxes', 'MODULE_BOXES_SHOPPING_CART_TITLE', 'Shopping Cart');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(600, 1, 'modules-boxes', 'MODULE_BOXES_SHOPPING_CART_DESCRIPTION', 'Show shopping cart contents');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(601, 1, 'modules-boxes', 'MODULE_BOXES_SHOPPING_CART_BOX_TITLE', 'Shopping Cart');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(602, 1, 'modules-boxes', 'MODULE_BOXES_SHOPPING_CART_BOX_CART_EMPTY', '0 items');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(603, 1, 'modules-boxes', 'MODULE_BOXES_SPECIALS_TITLE', 'Specials');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(604, 1, 'modules-boxes', 'MODULE_BOXES_SPECIALS_DESCRIPTION', 'Show products on special');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(605, 1, 'modules-boxes', 'MODULE_BOXES_SPECIALS_BOX_TITLE', 'Specials');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(606, 1, 'modules-boxes', 'MODULE_BOXES_WHATS_NEW_TITLE', 'What\\''s New');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(607, 1, 'modules-boxes', 'MODULE_BOXES_WHATS_NEW_DESCRIPTION', 'Show the newest products');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(608, 1, 'modules-boxes', 'MODULE_BOXES_WHATS_NEW_BOX_TITLE', 'What\\''s New?');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(609, 1, 'modules-action-recorder', 'MODULE_ACTION_RECORDER_ADMIN_LOGIN_TITLE', 'Administration Tool Login');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(610, 1, 'modules-action-recorder', 'MODULE_ACTION_RECORDER_ADMIN_LOGIN_DESCRIPTION', 'Record usage of Administration Tool logins.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(611, 1, 'modules-action-recorder', 'MODULE_ACTION_RECORDER_CONTACT_US_TITLE', 'Contact Us');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(612, 1, 'modules-action-recorder', 'MODULE_ACTION_RECORDER_CONTACT_US_DESCRIPTION', 'Record usage of the Contact Us feature.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(613, 1, 'modules-action-recorder', 'MODULE_ACTION_RECORDER_RESET_PASSWORD_TITLE', 'Customer Password Reset');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(614, 1, 'modules-action-recorder', 'MODULE_ACTION_RECORDER_RESET_PASSWORD_DESCRIPTION', 'Record usage of customer password resets.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(615, 1, 'modules-action-recorder', 'MODULE_ACTION_RECORDER_TELL_A_FRIEND_TITLE', 'Tell A Friend');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(616, 1, 'modules-action-recorder', 'MODULE_ACTION_RECORDER_TELL_A_FRIEND_DESCRIPTION', 'Record usage of the Tell A Friend feature.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(617, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_BRAINTREE_CARDS_TITLE', 'Braintree Cards Management Page');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(618, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_BRAINTREE_CARDS_DESCRIPTION', 'Adds a Braintree Cards management page to the My Account area');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(619, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_BRAINTREE_CARDS_ERROR_MAIN_MODULE', 'This module will not load until the Braintree payment module has been installed, configured, and is enabled. Please install and configure the Braintree payment module.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(620, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_BRAINTREE_CARDS_LINK_TITLE', 'Manage saved payment cards.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(621, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_BRAINTREE_CARDS_NAVBAR_TITLE_1', 'My Account');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(622, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_BRAINTREE_CARDS_NAVBAR_TITLE_2', 'Saved Cards');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(623, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_BRAINTREE_CARDS_HEADING_TITLE', 'Saved Cards');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(624, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_BRAINTREE_CARDS_TEXT_DESCRIPTION', '<p>Saved payment cards are stored securely and safely in a certified and audited PCI DSS compliant environment. This high level of security provides convenience in allowing saved cards to be used for next purchases without the card information having to be re-typed again for each order made.</p><p>New cards can be securely saved during the process of your next order.</p>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(625, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_BRAINTREE_CARDS_SAVED_CARDS_TITLE', 'Saved Cards');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(626, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_BRAINTREE_CARDS_TEXT_NO_CARDS', '<p>No cards have been saved yet.</p>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(627, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_BRAINTREE_CARDS_SUCCESS_DELETED', 'The card has been successfully deleted.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(628, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_SAGE_PAY_CARDS_TITLE', 'Sage Pay Cards Management Page');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(629, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_SAGE_PAY_CARDS_DESCRIPTION', 'Adds a Sage Pay Cards management page to the My Account area');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(630, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_SAGE_PAY_CARDS_ERROR_MAIN_MODULE', 'This module will not load until the Sage Pay Direct payment module has been installed, configured, and is enabled. Please install and configure the Sage Pay Direct payment module.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(631, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_SAGE_PAY_CARDS_LINK_TITLE', 'Manage saved payment cards.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(632, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_SAGE_PAY_CARDS_NAVBAR_TITLE_1', 'My Account');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(633, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_SAGE_PAY_CARDS_NAVBAR_TITLE_2', 'Saved Cards');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(634, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_SAGE_PAY_CARDS_HEADING_TITLE', 'Saved Cards');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(635, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_SAGE_PAY_CARDS_TEXT_DESCRIPTION', '<p>Saved payment cards are stored securely and safely in a certified and audited PCI DSS compliant environment. This high level of security provides convenience in allowing saved cards to be used for next purchases without the card information having to be re-typed again for each order made.</p><p>New cards can be securely saved during the process of your next order.</p>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(636, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_SAGE_PAY_CARDS_SAVED_CARDS_TITLE', 'Saved Cards');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(637, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_SAGE_PAY_CARDS_TEXT_NO_CARDS', '<p>No cards have been saved yet.</p>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(638, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_SAGE_PAY_CARDS_SUCCESS_DELETED', 'The card has been successfully deleted.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(639, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_SET_PASSWORD_TITLE', 'Set Account Password');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(640, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_SET_PASSWORD_DESCRIPTION', 'Replace Change Password page with Set Password page if no local account password has been set');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(641, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_SET_PASSWORD_SET_PASSWORD_LINK_TITLE', 'Set account password.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(642, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_SET_PASSWORD_NAVBAR_TITLE_1', 'My Account');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(643, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_SET_PASSWORD_NAVBAR_TITLE_2', 'Set Password');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(644, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_SET_PASSWORD_HEADING_TITLE', 'Set Password');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(645, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_SET_PASSWORD_SET_PASSWORD_TITLE', 'Set Password');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(646, 1, 'modules-content', 'MODULE_CONTENT_ACCOUNT_SET_PASSWORD_SUCCESS_PASSWORD_SET', 'Your password has been successfully saved.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(647, 1, 'modules-content', 'MODULE_CONTENT_CHECKOUT_SUCCESS_DOWNLOADS_TITLE', 'Product Downloads');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(648, 1, 'modules-content', 'MODULE_CONTENT_CHECKOUT_SUCCESS_DOWNLOADS_DESCRIPTION', 'Show ordered product download links on the checkout success page');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(649, 1, 'modules-content', 'TABLE_HEADING_DOWNLOAD_DATE', 'Expiry date: ');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(650, 1, 'modules-content', 'TABLE_HEADING_DOWNLOAD_COUNT', ' downloads remaining');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(651, 1, 'modules-content', 'HEADING_DOWNLOAD', 'Download your products here:');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(652, 1, 'modules-content', 'FOOTER_DOWNLOAD', 'You can also download your products at a later time at \\''%s\\''');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(653, 1, 'modules-content', 'MODULE_CONTENT_CHECKOUT_SUCCESS_PRODUCT_NOTIFICATIONS_TITLE', 'Product Notifications');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(654, 1, 'modules-content', 'MODULE_CONTENT_CHECKOUT_SUCCESS_PRODUCT_NOTIFICATIONS_DESCRIPTION', 'Add product notification to checkout success page');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(655, 1, 'modules-content', 'MODULE_CONTENT_CHECKOUT_SUCCESS_PRODUCT_NOTIFICATIONS_TEXT_NOTIFY_PRODUCTS', 'Please notify me of updates to the products I have selected below:');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(656, 1, 'modules-content', 'MODULE_CONTENT_CHECKOUT_SUCCESS_REDIRECT_OLD_ORDER_TITLE', 'Redirect Old Order');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(657, 1, 'modules-content', 'MODULE_CONTENT_CHECKOUT_SUCCESS_REDIRECT_OLD_ORDER_DESCRIPTION', 'Redirect the customer when an old order is being viewed.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(658, 1, 'modules-content', 'MODULE_CONTENT_CHECKOUT_SUCCESS_THANK_YOU_TITLE', 'Thank You');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(659, 1, 'modules-content', 'MODULE_CONTENT_CHECKOUT_SUCCESS_THANK_YOU_DESCRIPTION', 'Show thank you block on the checkout success page.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(660, 1, 'modules-content', 'MODULE_CONTENT_CHECKOUT_SUCCESS_TEXT_SUCCESS', 'Your order has been successfully processed! Your products will arrive at their destination within 2-5 working days.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(661, 1, 'modules-content', 'MODULE_CONTENT_CHECKOUT_SUCCESS_TEXT_SEE_ORDERS', 'You can view the status of your order any time in your account <a href="%s">View Orders</a> page.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(662, 1, 'modules-content', 'MODULE_CONTENT_CHECKOUT_SUCCESS_TEXT_CONTACT_STORE_OWNER', 'Please forward any questions you may have to us on our <a href="%s">Contact Us</a> page.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(663, 1, 'modules-content', 'MODULE_CONTENT_CHECKOUT_SUCCESS_TEXT_THANKS_FOR_SHOPPING', 'Thanks for shopping with us online!');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(664, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_ACCOUNT_TITLE', 'Account Block');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(665, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_ACCOUNT_DESCRIPTION', 'Adds an Account Block to the Footer Area of your site');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(666, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_ACCOUNT_HEADING_TITLE', 'Customer Services');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(667, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_ACCOUNT_BOX_ACCOUNT', 'My Account');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(668, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_ACCOUNT_BOX_ADDRESS_BOOK', 'My Address Book');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(669, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_ACCOUNT_BOX_ORDER_HISTORY', 'My Order History');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(670, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_ACCOUNT_BOX_LOGOFF', 'Secure Log Off');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(671, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_ACCOUNT_BOX_CREATE_ACCOUNT', 'Create Account');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(672, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_ACCOUNT_BOX_LOGIN', 'Existing Customer? Log In');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(673, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_CONTACT_US_TITLE', 'Contact Us Details');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(674, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_CONTACT_US_DESCRIPTION', 'Adds a Contact Us Block to the Footer Area of your site');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(675, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_CONTACT_US_HEADING_TITLE', 'How To Contact Us');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(676, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_CONTACT_US_EMAIL_LINK', 'Contact Us');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(677, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_INFORMATION_TITLE', 'Information Links Block');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(678, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_INFORMATION_DESCRIPTION', 'Adds Information Links Block to the Footer Area of your site');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(679, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_INFORMATION_HEADING_TITLE', 'Information');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(680, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_INFORMATION_SHIPPING', 'Shipping & Returns');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(681, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_INFORMATION_PRIVACY', 'Privacy & Cookie Policy');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(682, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_INFORMATION_CONDITIONS', 'Terms & Conditions');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(683, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_INFORMATION_CONTACT', 'Contact Us');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(684, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_TEXT_TITLE', 'Text Block');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(685, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_TEXT_DESCRIPTION', 'Adds a Text Block to the Footer Area of your site');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(686, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_TEXT_HEADING_TITLE', 'About Us');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(687, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_TEXT_TEXT', '<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\\''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.</p>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(688, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_EXTRA_COPYRIGHT_TITLE', 'Copyright Details');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(689, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_EXTRA_COPYRIGHT_DESCRIPTION', 'Adds a Copyright Block to the Extra Footer Area of your site');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(690, 1, 'modules-content', 'FOOTER_TEXT_BODY', '<p>Copyright &copy; ');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(691, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_EXTRA_ICONS_TITLE', 'Payment Icons');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(692, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_EXTRA_ICONS_DESCRIPTION', 'Adds a Payment Icons Block to the Extra Footer Area of your site');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(693, 1, 'modules-content', 'MODULE_CONTENT_FOOTER_EXTRA_ICONS_TEXT', '''\n  <p>\n    <i class="fa fa-cc fa-lg"></i>\n    <i class="fa fa-cc-amex fa-lg"></i>\n    <i class="fa fa-cc-discover fa-lg"></i>\n    <i class="fa fa-cc-mastercard fa-lg"></i>\n    <i class="fa fa-cc-paypal fa-lg"></i>\n    <i class="fa fa-cc-stripe fa-lg"></i>\n    <i class="fa fa-cc-visa fa-lg"></i>\n  </p>''');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(694, 1, 'modules-content', 'MODULE_CONTENT_HEADER_BREADCRUMB_TITLE', 'Breadcrumb');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(695, 1, 'modules-content', 'MODULE_CONTENT_HEADER_BREADCRUMB_DESCRIPTION', 'Adds a Breadrcumb Trail into the Header Area of your site.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(696, 1, 'modules-content', 'MODULE_CONTENT_HEADER_BUTTONS_TITLE', 'Buttons');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(697, 1, 'modules-content', 'MODULE_CONTENT_HEADER_BUTTONS_DESCRIPTION', 'Adds Login/Checkout Buttons into the Header Area of your site.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(698, 1, 'modules-content', 'MODULE_CONTENT_HEADER_BUTTONS_TITLE_LOGOFF', '<span class="hidden-xs hidden-sm">Log Off</span>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(699, 1, 'modules-content', 'MODULE_CONTENT_HEADER_BUTTONS_TITLE_MY_ACCOUNT', '<span class="hidden-xs hidden-sm">My Account</span>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(700, 1, 'modules-content', 'MODULE_CONTENT_HEADER_BUTTONS_TITLE_CHECKOUT', '<span class="hidden-xs">Checkout</span>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(701, 1, 'modules-content', 'MODULE_CONTENT_HEADER_BUTTONS_TITLE_CART_CONTENTS', '<span class="hidden-xs">Cart Contents</span>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(702, 1, 'modules-content', 'MODULE_CONTENT_HEADER_LOGO_TITLE', 'Logo');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(703, 1, 'modules-content', 'MODULE_CONTENT_HEADER_LOGO_DESCRIPTION', 'Adds your Logo into the Header Area of your site.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(704, 1, 'modules-content', 'MODULE_CONTENT_HEADER_MESSAGESTACK_TITLE', 'Message Stack Notifications');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(705, 1, 'modules-content', 'MODULE_CONTENT_HEADER_MESSAGESTACK_DESCRIPTION', 'Show the Message Stack Notifications on your site.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(706, 1, 'modules-content', 'MODULE_CONTENT_HEADER_SEARCH_TITLE', 'Search Box');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(707, 1, 'modules-content', 'MODULE_CONTENT_HEADER_SEARCH_DESCRIPTION', 'Adds your Search Box into the Header Area of your site.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(708, 1, 'modules-content', 'MODULE_CONTENT_CREATE_ACCOUNT_LINK_TITLE', 'Create Account Link');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(709, 1, 'modules-content', 'MODULE_CONTENT_CREATE_ACCOUNT_LINK_DESCRIPTION', 'Show a create account container on the login page');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(710, 1, 'modules-content', 'MODULE_CONTENT_LOGIN_HEADING_NEW_CUSTOMER', 'New Customer');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(711, 1, 'modules-content', 'MODULE_CONTENT_LOGIN_TEXT_NEW_CUSTOMER', 'I am a new customer.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(712, 1, 'modules-content', 'MODULE_CONTENT_LOGIN_TEXT_NEW_CUSTOMER_INTRODUCTION', 'By creating an account at ');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(713, 1, 'modules-content', 'MODULE_CONTENT_LOGIN_FORM_TITLE', 'Login Form');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(714, 1, 'modules-content', 'MODULE_CONTENT_LOGIN_FORM_DESCRIPTION', 'Show a login form on the login page');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(715, 1, 'modules-content', 'MODULE_CONTENT_LOGIN_HEADING_RETURNING_CUSTOMER', 'Returning Customer');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(716, 1, 'modules-content', 'MODULE_CONTENT_LOGIN_TEXT_RETURNING_CUSTOMER', 'I am a returning customer.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(717, 1, 'modules-content', 'MODULE_CONTENT_LOGIN_TEXT_PASSWORD_FORGOTTEN', 'Password forgotten? Click here.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(718, 1, 'modules-content', 'MODULE_CONTENT_LOGIN_TEXT_LOGIN_ERROR', 'Error: No match for E-Mail Address and/or Password.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(719, 1, 'modules-content', 'MODULE_CONTENT_NAVBAR_TITLE', 'Navigation Bar');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(720, 1, 'modules-content', 'MODULE_CONTENT_NAVBAR_DESCRIPTION', 'Show the Navigation Bar on your site.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(721, 1, 'modules-content', 'MODULE_CONTENT_NAVBAR_CART_CONTENTS', '<i class="glyphicon glyphicon-shopping-cart"></i> %s item(s) <span class="caret"></span>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(722, 1, 'modules-content', 'MODULE_CONTENT_NAVBAR_CART_NO_CONTENTS', '<i class="glyphicon glyphicon-shopping-cart"></i> 0 items');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(723, 1, 'modules-content', 'MODULE_CONTENT_NAVBAR_ACCOUNT_LOGGED_OUT', '<i class="glyphicon glyphicon-user"></i><span class="hidden-sm"> My Account</span> <span class="caret"></span>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(724, 1, 'modules-content', 'MODULE_CONTENT_NAVBAR_ACCOUNT_LOGGED_IN', '<i class="glyphicon glyphicon-user"></i> %s <span class="caret"></span>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(725, 1, 'modules-content', 'MODULE_CONTENT_NAVBAR_SITE_SETTINGS', '<i class="glyphicon glyphicon-cog"></i><span class="hidden-sm"> Site Settings</span> <span class="caret"></span>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(726, 1, 'modules-content', 'MODULE_CONTENT_NAVBAR_TOGGLE_NAV', 'Toggle Navigation');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(727, 1, 'modules-content', 'MODULE_CONTENT_NAVBAR_HOME', '<i class="glyphicon glyphicon-home"></i><span class="hidden-sm"> Home</span>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(728, 1, 'modules-content', 'MODULE_CONTENT_NAVBAR_WHATS_NEW', '<i class="glyphicon glyphicon-certificate"></i><span class="hidden-sm">  New Products</span>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(729, 1, 'modules-content', 'MODULE_CONTENT_NAVBAR_SPECIALS', '<i class="glyphicon glyphicon-fire"></i><span class="hidden-sm"> Special Offers</span>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(730, 1, 'modules-content', 'MODULE_CONTENT_NAVBAR_REVIEWS', '<i class="glyphicon glyphicon-comment"></i><span class="hidden-sm"> Reviews</span>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(731, 1, 'modules-content', 'MODULE_CONTENT_NAVBAR_ACCOUNT_LOGIN', '<i class="glyphicon glyphicon-log-in"></i> Log In');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(732, 1, 'modules-content', 'MODULE_CONTENT_NAVBAR_ACCOUNT_LOGOFF', '<i class="glyphicon glyphicon-log-out"></i> Log Off');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(733, 1, 'modules-content', 'MODULE_CONTENT_NAVBAR_ACCOUNT', 'My Account');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(734, 1, 'modules-content', 'MODULE_CONTENT_NAVBAR_ACCOUNT_HISTORY', 'My Orders');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(735, 1, 'modules-content', 'MODULE_CONTENT_NAVBAR_ACCOUNT_EDIT', 'My Details');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(736, 1, 'modules-content', 'MODULE_CONTENT_NAVBAR_ACCOUNT_ADDRESS_BOOK', 'My Address Book');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(737, 1, 'modules-content', 'MODULE_CONTENT_NAVBAR_ACCOUNT_PASSWORD', 'My Password');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(738, 1, 'modules-content', 'MODULE_CONTENT_NAVBAR_ACCOUNT_REGISTER', '<i class="glyphicon glyphicon-pencil"></i> Register');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(739, 1, 'modules-content', 'MODULE_CONTENT_NAVBAR_CART_HAS_CONTENTS', '%s item(s), %s');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(740, 1, 'modules-content', 'MODULE_CONTENT_NAVBAR_CART_VIEW_CART', 'View Cart');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(741, 1, 'modules-content', 'MODULE_CONTENT_NAVBAR_CART_CHECKOUT', '<i class="glyphicon glyphicon-chevron-right"></i> Checkout');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(742, 1, 'modules-content', 'MODULE_CONTENT_NAVBAR_USER_LOCALIZATION', '<abbr title="Selected Language">L:</abbr> English <abbr title="Selected Currency">C:</abbr> %s');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(743, 1, 'modules-content', 'MODULE_CONTENT_PRODUCT_INFO_REVIEWS_TITLE', 'Product Reviews');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(744, 1, 'modules-content', 'MODULE_CONTENT_PRODUCT_INFO_REVIEWS_DESCRIPTION', 'Show review block on the product info page.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(745, 1, 'modules-content', 'MODULE_CONTENT_PRODUCT_INFO_REVIEWS_TEXT_TITLE', 'Product Reviews');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(746, 1, 'modules-content', 'MODULE_CONTENT_PRODUCT_INFO_REVIEWS_TEXT_RATED', 'Rated %s by <cite title="%s">%s</cite>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(747, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_BACKTOTOP_TITLE', 'Back To Top Link');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(748, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_BACKTOTOP_DESCRIPTION', 'Shows a "back to top" link to the user if they are looking at a long page.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(749, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_BACKTOTOP_LINK', 'Top of the Page!');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(750, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_CANONICAL_TITLE', 'Canonical Header Links');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(751, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_CANONICAL_DESCRIPTION', 'Add header canonical links to category and product pages');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(752, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_CATEGORY_TITLE_TITLE', 'Category Title');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(753, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_CATEGORY_TITLE_DESCRIPTION', 'Add the title of the current category to the page title');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(754, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_DATEPICKER_JQUERY_TITLE', 'Datepicker jQuery');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(755, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_DATEPICKER_JQUERY_DESCRIPTION', 'Add Datepicker jQuery to specified pages');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(756, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_DIV_EQUAL_HEIGHTS_TITLE', 'Equal Height Divs (jQuery)');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(757, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_DIV_EQUAL_HEIGHTS_DESCRIPTION', 'Add Equal Heights javascript to specified pages, which solves a potential problem in grid layouts');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(758, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_GOOGLE_ADWORDS_CONVERSION_TITLE', 'Google AdWords Conversion Tracking');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(759, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_GOOGLE_ADWORDS_CONVERSION_DESCRIPTION', 'Add Google AdWords Conversion Tracking to the Checkout Success page');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(760, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_GOOGLE_ANALYTICS_TITLE', 'Google Analytics');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(761, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_GOOGLE_ANALYTICS_DESCRIPTION', 'Add Google Analytics to the shop');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(762, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_GRID_LIST_VIEW_TITLE', 'Grid List Javascript (jQuery)');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(763, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_GRID_LIST_VIEW_DESCRIPTION', 'Add Grid List javascript to specified pages, which invokes a Grid/List view for product lists');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(764, 1, 'modules-header-tags', 'TEXT_VIEW', 'View: ');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(765, 1, 'modules-header-tags', 'TEXT_VIEW_LIST', ' List');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(766, 1, 'modules-header-tags', 'TEXT_VIEW_GRID', ' Grid');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(767, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_MAILCHIMP_360_TITLE', 'MailChimp E-Commerce 360');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(768, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_MAILCHIMP_360_DESCRIPTION', '<img src="images/icon_popup.gif" border="0">&nbsp;<a href="http://eepurl.com/bxza1" target="_blank" style="text-decoration: underline; font-weight: bold;">Visit MailChimp Website</a>&nbsp;<a href="javascript:toggleDivBlock(\\''mailchimpInfo\\'');">(info)</a><span id="mailchimpInfo" style="display: none;"><br /><i>Using the above link to signup at MailChimp grants osCommerce a small financial bonus for referring a customer.</i></span><br /><br />The MailChimp E-Commerce 360 module measures the ROI of your MailChimp e-mail campaigns');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(769, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_MANUFACTURER_TITLE_TITLE', 'Manufacturer Title');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(770, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_MANUFACTURER_TITLE_DESCRIPTION', 'Add the title of the current manufacturer to the page title');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(771, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_OPENSEARCH_TITLE', 'OpenSearch');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(772, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_OPENSEARCH_DESCRIPTION', 'Allow the browser to search the shop via OpenSearch');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(773, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_PRODUCT_COLORBOX_TITLE', 'Colorbox Script');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(774, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_PRODUCT_COLORBOX_DESCRIPTION', 'Add Colorbox Script to specified pages');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(775, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_PRODUCT_TITLE_TITLE', 'Product Title');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(776, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_PRODUCT_TITLE_DESCRIPTION', 'Add the title of the current product to the page title');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(777, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_ROBOT_NOINDEX_TITLE', 'Robot NoIndex');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(778, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_ROBOT_NOINDEX_DESCRIPTION', 'Add robot noindex tags to specified pages');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(779, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_TABLE_CLICK_JQUERY_TITLE', 'Table Row Click jQuery');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(780, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_TABLE_CLICK_JQUERY_DESCRIPTION', 'Add Table Row Click jQuery to specified pages');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(781, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_TWITTER_PRODUCT_CARD_TITLE', 'Twitter Product Card');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(782, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_TWITTER_PRODUCT_CARD_DESCRIPTION', 'Add Twitter Product Card tags to your product information pages.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(783, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_TWITTER_PRODUCT_CARD_TEXT_PRE_ORDER', 'Pre-Order');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(784, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_TWITTER_PRODUCT_CARD_TEXT_IN_STOCK', 'In Stock');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(785, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_TWITTER_PRODUCT_CARD_TEXT_OUT_OF_STOCK', 'Out of Stock');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(786, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_TWITTER_PRODUCT_CARD_TEXT_BUY_NOW', 'BUY NOW');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(787, 1, 'modules-header-tags', 'MODULE_HEADER_TAGS_TWITTER_PRODUCT_CARD_TEXT_CONTACT_US', 'CONTACT US');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(788, 1, 'modules-order-total', 'MODULE_ORDER_TOTAL_LOWORDERFEE_TITLE', 'Low Order Fee');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(789, 1, 'modules-order-total', 'MODULE_ORDER_TOTAL_LOWORDERFEE_DESCRIPTION', 'Low Order Fee');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(790, 1, 'modules-order-total', 'MODULE_ORDER_TOTAL_SHIPPING_TITLE', 'Shipping');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(791, 1, 'modules-order-total', 'MODULE_ORDER_TOTAL_SHIPPING_DESCRIPTION', 'Order Shipping Cost');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(792, 1, 'modules-order-total', 'FREE_SHIPPING_TITLE', 'Free Shipping');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(793, 1, 'modules-order-total', 'FREE_SHIPPING_DESCRIPTION', 'Free shipping for orders over %s');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(794, 1, 'modules-order-total', 'MODULE_ORDER_TOTAL_SUBTOTAL_TITLE', 'Sub-Total');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(795, 1, 'modules-order-total', 'MODULE_ORDER_TOTAL_SUBTOTAL_DESCRIPTION', 'Order Sub-Total');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(796, 1, 'modules-order-total', 'MODULE_ORDER_TOTAL_TAX_TITLE', 'Tax');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(797, 1, 'modules-order-total', 'MODULE_ORDER_TOTAL_TAX_DESCRIPTION', 'Order Tax');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(798, 1, 'modules-order-total', 'MODULE_ORDER_TOTAL_TOTAL_TITLE', 'Total');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(799, 1, 'modules-order-total', 'MODULE_ORDER_TOTAL_TOTAL_DESCRIPTION', 'Order Total');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(800, 1, 'modules-payment', 'MODULE_PAYMENT_BRAINTREE_CC_TEXT_TITLE', 'Braintree Payment Solutions');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(801, 1, 'modules-payment', 'MODULE_PAYMENT_BRAINTREE_CC_TEXT_PUBLIC_TITLE', 'Credit Card');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(802, 1, 'modules-payment', 'MODULE_PAYMENT_BRAINTREE_CC_TEXT_DESCRIPTION', '<img src="images/icon_info.gif" border="0" />&nbsp;<a href="http://library.oscommerce.com/Package&en&braintree&oscom23&braintree_js" target="_blank" style="text-decoration: underline; font-weight: bold;">View Online Documentation</a><br /><br /><img src="images/icon_popup.gif" border="0">&nbsp;<a href="https://www.braintreepayments.com" target="_blank" style="text-decoration: underline; font-weight: bold;">Visit Braintree Payments Website</a>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(803, 1, 'modules-payment', 'MODULE_PAYMENT_BRAINTREE_CC_ERROR_ADMIN_PHP', 'The minimum PHP version this module supports is %s and will not load until the webserver has been installed with a newer version.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(804, 1, 'modules-payment', 'MODULE_PAYMENT_BRAINTREE_CC_ERROR_ADMIN_PHP_EXTENSIONS', 'This module requires the following PHP extensions and will and will not load until PHP has been updated:<br /><br />%s');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(805, 1, 'modules-payment', 'MODULE_PAYMENT_BRAINTREE_CC_ERROR_ADMIN_MERCHANT_ACCOUNTS', 'This module will not load until a merchant account has been defined for the %s currency.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(806, 1, 'modules-payment', 'MODULE_PAYMENT_BRAINTREE_CC_ERROR_ADMIN_CONFIGURATION', 'This module will not load until the Merchant ID, Public Key, Private Key, and Client Side Encryption Key parameters have been configured. Please edit and configure the settings of this module.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(807, 1, 'modules-payment', 'MODULE_PAYMENT_BRAINTREE_CC_CREDITCARD_NEW', 'Enter a new Card');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(808, 1, 'modules-payment', 'MODULE_PAYMENT_BRAINTREE_CC_CREDITCARD_LAST_4', 'Last 4 Digits:');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(809, 1, 'modules-payment', 'MODULE_PAYMENT_BRAINTREE_CC_CREDITCARD_OWNER', 'Name on Card:');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(810, 1, 'modules-payment', 'MODULE_PAYMENT_BRAINTREE_CC_CREDITCARD_NUMBER', 'Card Number:');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(811, 1, 'modules-payment', 'MODULE_PAYMENT_BRAINTREE_CC_CREDITCARD_EXPIRY', 'Expiry Date:');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(812, 1, 'modules-payment', 'MODULE_PAYMENT_BRAINTREE_CC_CREDITCARD_CVV', 'Security Code:');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(813, 1, 'modules-payment', 'MODULE_PAYMENT_BRAINTREE_CC_CREDITCARD_SAVE', 'Save Card for next purchase?');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(814, 1, 'modules-payment', 'MODULE_PAYMENT_BRAINTREE_CC_CURRENCY_CHARGE', 'The currency currently used to display prices is in %3$s. Your credit card will be charged a total of <span style="white-space: nowrap;">%1$s %2$s</span> for this order.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(815, 1, 'modules-payment', 'MODULE_PAYMENT_BRAINTREE_CC_ERROR_TITLE', 'There has been an error processing your credit card');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(816, 1, 'modules-payment', 'MODULE_PAYMENT_BRAINTREE_CC_ERROR_GENERAL', 'Please try again and if problems persist, please try another payment method.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(817, 1, 'modules-payment', 'MODULE_PAYMENT_BRAINTREE_CC_ERROR_CARDOWNER', 'The card owners name must be provided to complete the order. Please try again and if problems persist, please try another payment method.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(818, 1, 'modules-payment', 'MODULE_PAYMENT_BRAINTREE_CC_ERROR_CARDNUMBER', 'The card number was not able to be processed. Please try again and if problems persist, please try another payment method.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(819, 1, 'modules-payment', 'MODULE_PAYMENT_BRAINTREE_CC_ERROR_CARDEXPIRES', 'The card expiry date was not able to be processed. Please try again and if problems persist, please try another payment method.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(820, 1, 'modules-payment', 'MODULE_PAYMENT_BRAINTREE_CC_ERROR_CARDCVV', 'The card security code was not able to be processed. Please try again and if problems persist, please try another payment method.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(821, 1, 'modules-payment', 'MODULE_PAYMENT_COD_TEXT_TITLE', 'Cash on Delivery');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(822, 1, 'modules-payment', 'MODULE_PAYMENT_COD_TEXT_DESCRIPTION', 'Cash on Delivery');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(823, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_TEXT_TITLE', 'Sage Pay Direct');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(824, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_TEXT_PUBLIC_TITLE', 'Credit Card (Processed by Sage Pay)');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(825, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_TEXT_DESCRIPTION', '<img src="images/icon_info.gif" border="0" />&nbsp;<a href="http://library.oscommerce.com/Package&en&sage_pay&oscom23&direct" target="_blank" style="text-decoration: underline; font-weight: bold;">View Online Documentation</a><br /><br /><img src="images/icon_popup.gif" border="0">&nbsp;<a href="https://support.sagepay.com/apply/default.aspx?PartnerID=E194E079-84A9-493C-AB9A-91CB362D3238&PromotionCode=osc3MF" target="_blank" style="text-decoration: underline; font-weight: bold;">Visit Sage Pay Website</a>&nbsp;<a href="javascript:toggleDivBlock(\\''sagePayInfo\\'');">(info)</a><span id="sagePayInfo" style="display: none;"><br /><i>Using the above link to signup at Sage Pay grants osCommerce a small financial bonus for referring a customer.</i></span>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(826, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_ERROR_ADMIN_CURL', 'This module requires cURL to be enabled in PHP and will not load until it has been enabled on this webserver.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(827, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_ERROR_ADMIN_CONFIGURATION', 'This module will not load until the Vendor Login Name parameter has been configured. Please edit and configure the settings of this module.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(828, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_CREDIT_CARD_NEW', 'Enter a new Card');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(829, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_CREDIT_CARD_TYPE', 'Card Type:');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(830, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_CREDIT_CARD_OWNER', 'Name on Card:');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(831, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_CREDIT_CARD_NUMBER', 'Card Number:');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(832, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_CREDIT_CARD_STARTS', 'Start Date:');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(833, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_CREDIT_CARD_STARTS_INFO', '(for Maestro and American Express cards only)');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(834, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_CREDIT_CARD_EXPIRES', 'Expiry Date:');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(835, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_CREDIT_CARD_ISSUE_NUMBER', 'Issue Number:');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(836, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_CREDIT_CARD_ISSUE_NUMBER_INFO', '(for Maestro cards only)');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(837, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_CREDIT_CARD_CVC', 'Security Code:');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(838, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_CREDIT_CARD_SAVE', 'Save Card for next purchase?');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(839, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_3DAUTH_TITLE', '3D Secure Verification');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(840, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_3DAUTH_INFO', 'Please click on the CONTINUE button to authenticate your card at the website of your bank.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(841, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_3DAUTH_BUTTON', 'CONTINUE');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(842, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_ERROR_TITLE', 'There has been an error processing your credit card');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(843, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_ERROR_GENERAL', 'Please try again and if problems persist, please try another payment method.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(844, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_ERROR_CARDTYPE', 'The card type is not supported. Please try again with another card and if problems persist, please try another payment method.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(845, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_ERROR_CARDOWNER', 'The card owners name must be provided to complete the order. Please try again and if problems persist, please try another payment method.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(846, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_ERROR_CARDNUMBER', 'The card number was not able to be processed. Please try again and if problems persist, please try another payment method.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(847, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_ERROR_CARDSTART', 'The card start date was not able to be processed. Please try again and if problems persist, please try another payment method.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(848, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_ERROR_CARDEXPIRES', 'The card expiry date was not able to be processed. Please try again and if problems persist, please try another payment method.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(849, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_ERROR_CARDISSUE', 'The card issue number was not able to be processed. Please try again and if problems persist, please try another payment method.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(850, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_ERROR_CARDCVC', 'The card security code was not able to be processed. Please try again and if problems persist, please try another payment method.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(851, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_DIALOG_CONNECTION_LINK_TITLE', 'Test API Server Connection');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(852, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_DIALOG_CONNECTION_TITLE', 'API Server Connection Test');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(853, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_DIALOG_CONNECTION_GENERAL_TEXT', 'Testing connection to server..');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(854, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_DIALOG_CONNECTION_BUTTON_CLOSE', 'Close');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(855, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_DIALOG_CONNECTION_TIME', 'Connection Time:');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(856, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_DIALOG_CONNECTION_SUCCESS', 'Success!');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(857, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_DIALOG_CONNECTION_FAILED', 'Failed! Please review the Verify SSL Certificate settings and try again.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(858, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_DIRECT_DIALOG_CONNECTION_ERROR', 'An error occurred. Please refresh the page, review your settings, and try again.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(859, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_FORM_TEXT_TITLE', 'Sage Pay Form');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(860, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_FORM_TEXT_PUBLIC_TITLE', 'Credit Card or Bank Card (Processed by Sage Pay)');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(861, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_FORM_TEXT_DESCRIPTION', '<img src="images/icon_info.gif" border="0" />&nbsp;<a href="http://library.oscommerce.com/Package&en&sage_pay&oscom23&form" target="_blank" style="text-decoration: underline; font-weight: bold;">View Online Documentation</a><br /><br /><img src="images/icon_popup.gif" border="0">&nbsp;<a href="https://support.sagepay.com/apply/default.aspx?PartnerID=E194E079-84A9-493C-AB9A-91CB362D3238&PromotionCode=osc3MF" target="_blank" style="text-decoration: underline; font-weight: bold;">Visit Sage Pay Website</a>&nbsp;<a href="javascript:toggleDivBlock(\\''sagePayInfo\\'');">(info)</a><span id="sagePayInfo" style="display: none;"><br /><i>Using the above link to signup at Sage Pay grants osCommerce a small financial bonus for referring a customer.</i></span>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(862, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_FORM_ERROR_ADMIN_MCRYPT', 'This module requires Mcrypt to be enabled in PHP and will not load until it has been enabled on this webserver.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(863, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_FORM_ERROR_ADMIN_CONFIGURATION', 'This module will not load until the Vendor Login Name and Encryption Password parameters have been configured. Please edit and configure the settings of this module.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(864, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_FORM_ERROR_TITLE', 'There has been an error processing your order transaction');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(865, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_FORM_ERROR_GENERAL', 'Please try again and if problems persist, please try another payment method.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(866, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_SERVER_TEXT_TITLE', 'Sage Pay Server');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(867, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_SERVER_TEXT_PUBLIC_TITLE', 'Credit Card or Bank Card (Processed by Sage Pay)');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(868, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_SERVER_TEXT_DESCRIPTION', '<img src="images/icon_info.gif" border="0" />&nbsp;<a href="http://library.oscommerce.com/Package&en&sage_pay&oscom23&server" target="_blank" style="text-decoration: underline; font-weight: bold;">View Online Documentation</a><br /><br /><img src="images/icon_popup.gif" border="0">&nbsp;<a href="https://support.sagepay.com/apply/default.aspx?PartnerID=E194E079-84A9-493C-AB9A-91CB362D3238&PromotionCode=osc3MF" target="_blank" style="text-decoration: underline; font-weight: bold;">Visit Sage Pay Website</a>&nbsp;<a href="javascript:toggleDivBlock(\\''sagePayInfo\\'');">(info)</a><span id="sagePayInfo" style="display: none;"><br /><i>Using the above link to signup at Sage Pay grants osCommerce a small financial bonus for referring a customer.</i></span>');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(869, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_SERVER_ERROR_ADMIN_CURL', 'This module requires cURL to be enabled in PHP and will not load until it has been enabled on this webserver.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(870, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_SERVER_ERROR_ADMIN_CONFIGURATION', 'This module will not load until the Vendor Login Name parameter has been configured. Please edit and configure the settings of this module.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(871, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_SERVER_ERROR_TITLE', 'There has been an error processing your credit card');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(872, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_SERVER_ERROR_GENERAL', 'Please try again and if problems persist, please try another payment method.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(873, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_SERVER_DIALOG_CONNECTION_LINK_TITLE', 'Test API Server Connection');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(874, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_SERVER_DIALOG_CONNECTION_TITLE', 'API Server Connection Test');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(875, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_SERVER_DIALOG_CONNECTION_GENERAL_TEXT', 'Testing connection to server..');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(876, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_SERVER_DIALOG_CONNECTION_BUTTON_CLOSE', 'Close');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(877, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_SERVER_DIALOG_CONNECTION_TIME', 'Connection Time:');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(878, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_SERVER_DIALOG_CONNECTION_SUCCESS', 'Success!');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(879, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_SERVER_DIALOG_CONNECTION_FAILED', 'Failed! Please review the Verify SSL Certificate settings and try again.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(880, 1, 'modules-payment', 'MODULE_PAYMENT_SAGE_PAY_SERVER_DIALOG_CONNECTION_ERROR', 'An error occurred. Please refresh the page, review your settings, and try again.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(881, 1, 'modules-shipping', 'MODULE_SHIPPING_FLAT_TEXT_TITLE', 'Flat Rate');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(882, 1, 'modules-shipping', 'MODULE_SHIPPING_FLAT_TEXT_DESCRIPTION', 'Flat Rate');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(883, 1, 'modules-shipping', 'MODULE_SHIPPING_FLAT_TEXT_WAY', '');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(884, 1, 'modules-shipping', 'MODULE_SHIPPING_ITEM_TEXT_TITLE', 'Per Item');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(885, 1, 'modules-shipping', 'MODULE_SHIPPING_ITEM_TEXT_DESCRIPTION', 'Per Item');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(886, 1, 'modules-shipping', 'MODULE_SHIPPING_ITEM_TEXT_WAY', '');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(887, 1, 'modules-shipping', 'MODULE_SHIPPING_TABLE_TEXT_TITLE', 'Table Rate');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(888, 1, 'modules-shipping', 'MODULE_SHIPPING_TABLE_TEXT_DESCRIPTION', 'Table Rate');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(889, 1, 'modules-shipping', 'MODULE_SHIPPING_TABLE_TEXT_WAY', '');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(890, 1, 'modules-shipping', 'MODULE_SHIPPING_TABLE_TEXT_WEIGHT', 'Weight');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(891, 1, 'modules-shipping', 'MODULE_SHIPPING_TABLE_TEXT_AMOUNT', 'Amount');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(892, 1, 'modules-shipping', 'MODULE_SHIPPING_ZONES_TEXT_TITLE', 'Zone Rates');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(893, 1, 'modules-shipping', 'MODULE_SHIPPING_ZONES_TEXT_DESCRIPTION', 'Zone Based Rates');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(894, 1, 'modules-shipping', 'MODULE_SHIPPING_ZONES_TEXT_WAY', 'Shipping to');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(895, 1, 'modules-shipping', 'MODULE_SHIPPING_ZONES_TEXT_UNITS', 'lb(s)');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(896, 1, 'modules-shipping', 'MODULE_SHIPPING_ZONES_INVALID_ZONE', 'No shipping available to the selected country');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(897, 1, 'modules-shipping', 'MODULE_SHIPPING_ZONES_UNDEFINED_RATE', 'The shipping rate cannot be determined at this time');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(898, 1, 'modules-social-bookmarks', 'MODULE_SOCIAL_BOOKMARKS_DIGG_TITLE', 'Digg');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(899, 1, 'modules-social-bookmarks', 'MODULE_SOCIAL_BOOKMARKS_DIGG_DESCRIPTION', 'Share products on Digg.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(900, 1, 'modules-social-bookmarks', 'MODULE_SOCIAL_BOOKMARKS_DIGG_PUBLIC_TITLE', 'Share on Digg');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(901, 1, 'modules-social-bookmarks', 'MODULE_SOCIAL_BOOKMARKS_EMAIL_TITLE', 'E-Mail');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(902, 1, 'modules-social-bookmarks', 'MODULE_SOCIAL_BOOKMARKS_EMAIL_DESCRIPTION', 'Share products via e-mail.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(903, 1, 'modules-social-bookmarks', 'MODULE_SOCIAL_BOOKMARKS_EMAIL_PUBLIC_TITLE', 'Share via E-Mail');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(904, 1, 'modules-social-bookmarks', 'MODULE_SOCIAL_BOOKMARKS_FACEBOOK_TITLE', 'Facebook');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(905, 1, 'modules-social-bookmarks', 'MODULE_SOCIAL_BOOKMARKS_FACEBOOK_DESCRIPTION', 'Share products on Facebook.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(906, 1, 'modules-social-bookmarks', 'MODULE_SOCIAL_BOOKMARKS_FACEBOOK_PUBLIC_TITLE', 'Share on Facebook');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(907, 1, 'modules-social-bookmarks', 'MODULE_SOCIAL_BOOKMARKS_FACEBOOK_LIKE_TITLE', 'Facebook Like');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(908, 1, 'modules-social-bookmarks', 'MODULE_SOCIAL_BOOKMARKS_FACEBOOK_LIKE_DESCRIPTION', 'Share products on Facebook Like.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(909, 1, 'modules-social-bookmarks', 'MODULE_SOCIAL_BOOKMARKS_FACEBOOK_LIKE_PUBLIC_TITLE', 'Share on Facebook');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(910, 1, 'modules-social-bookmarks', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS_ONE_TITLE', 'Google+ +1 Button');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(911, 1, 'modules-social-bookmarks', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS_ONE_DESCRIPTION', 'Recommend products through Google+ +1 Button.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(912, 1, 'modules-social-bookmarks', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS_ONE_PUBLIC_TITLE', 'Recommend on Google+');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(913, 1, 'modules-social-bookmarks', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS_SHARE_TITLE', 'Google+ Share');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(914, 1, 'modules-social-bookmarks', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS_SHARE_DESCRIPTION', 'Share products on Google+.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(915, 1, 'modules-social-bookmarks', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS_SHARE_PUBLIC_TITLE', 'Share on Google+');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(916, 1, 'modules-social-bookmarks', 'MODULE_SOCIAL_BOOKMARKS_PINTEREST_TITLE', 'Pinterest');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(917, 1, 'modules-social-bookmarks', 'MODULE_SOCIAL_BOOKMARKS_PINTEREST_DESCRIPTION', 'Share on Pinterest');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(918, 1, 'modules-social-bookmarks', 'MODULE_SOCIAL_BOOKMARKS_PINTEREST_PUBLIC_TITLE', 'Pin It');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(919, 1, 'modules-social-bookmarks', 'MODULE_SOCIAL_BOOKMARKS_TWITTER_TITLE', 'Twitter');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(920, 1, 'modules-social-bookmarks', 'MODULE_SOCIAL_BOOKMARKS_TWITTER_DESCRIPTION', 'Share products on Twitter.');
INSERT INTO osc_languages_definitions (id, languages_id, content_group, definition_key, definition_value) VALUES(921, 1, 'modules-social-bookmarks', 'MODULE_SOCIAL_BOOKMARKS_TWITTER_PUBLIC_TITLE', 'Share on Twitter');

