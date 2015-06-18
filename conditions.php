<?php
	/*
		$Id$
		
		osCommerce, Open Source E-Commerce Solutions
		http://www.oscommerce.com
		
		Copyright (c) 2015 osCommerce
		
		Released under the GNU General Public License
	*/
	
	use OSC\OM\HTML;
	use OSC\OM\OSCOM;
	
	require('includes/application_top.php');
	
	$breadcrumb->add(NAVBAR_TITLE, OSCOM::link('conditions.php'));
	
	require('includes/template_top.php');
?>

<div class="page-header">
	<h1><?php echo $osC_Language->get('CONDITIONS_HEADING_TITLE'); ?></h1>
</div>

<div class="contentContainer">
	<div class="contentText">
		<?php echo $osC_Language->get('CONDITIONS_TEXT_INFORMATION'); ?>
	</div>
	
	<div class="text-right">
		<?php echo HTML::button($osC_Language->get('IMAGE_BUTTON_CONTINUE'), 'glyphicon glyphicon-chevron-right', OSCOM::link('index.php')); ?>
	</div>
</div>

<?php
	require('includes/template_bottom.php');
	require('includes/application_bottom.php');
?>
