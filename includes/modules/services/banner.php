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

  class osC_Services_banner {
    function start() {
      global $osC_Banner;

      include('modules/oscommerce/includes/classes/banner.php');
      $osC_Banner = new osC_Banner();

      $osC_Banner->activateAll();
      $osC_Banner->expireAll();

      return true;
    }

    function stop() {
      return true;
    }
  }
?>
