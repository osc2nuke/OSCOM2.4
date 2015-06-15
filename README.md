# OSCOM2.4
osCommerce's v3 classes to osCommerce 2.4

This repository aims to include the older osCommerce V3 classes to osCommerce 2.4
NOTE For the contributers :

To convert the old language system to the new, find all language constance 's and replace them like below.

Be aware that whenever a language constant is within a function you not forget to add the global (see in example).

 

Do not mix up configuration constants with language constants.

    function bm_whats_new() {
      global $osC_Language;
	  
      $this->title = $osC_Language->get('MODULE_BOXES_WHATS_NEW_TITLE');
      $this->description = $osC_Language->get('MODULE_BOXES_WHATS_NEW_DESCRIPTION');

      if ( defined('MODULE_BOXES_WHATS_NEW_STATUS') ) {
        $this->sort_order = MODULE_BOXES_WHATS_NEW_SORT_ORDER;
        $this->enabled = (MODULE_BOXES_WHATS_NEW_STATUS == 'True');

        $this->group = ((MODULE_BOXES_WHATS_NEW_CONTENT_PLACEMENT == 'Left Column') ? 'boxes_column_left' : 'boxes_column_right');
      }
    }

NOTE: Language constants for previous root files are called as :

 

Consider you working on product info and you go edit the constant : TEXT_PRODUCT_NOT_FOUND

 

this will become now :

$osC_Language->get('PRODUCT_INFO_TEXT_PRODUCT_NOT_FOUND');

Because oscommerce 2.3.X to 2.4 contains various duplicated constants, the best way to solve it was using the filename before the actual constant.

 

Once you made a change and want to see the effect, do not forget to truncate the cache files in the WORK directory.

 

NOTE: all instances for

$XXX->bindInt(':language_id', $_SESSION['languages_id']);

should be replaced by:

$XXX->bindInt(':language_id', $osC_Language->getID());
