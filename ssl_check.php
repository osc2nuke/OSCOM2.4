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
	
	$breadcrumb->add($osC_Language->get('SSL_CHECK_NAVBAR_TITLE'), OSCOM::link('ssl_check.php'));
	
	require('includes/template_top.php');
?>

<div class="page-header">
	<h1><?php echo $osC_Language->get('SSL_CHECK_HEADING_TITLE'); ?></h1>
</div>

<div class="contentContainer">
	<div class="contentText">
		
		<div class="panel panel-danger">
			<div class="panel-heading"><?php echo $osC_Language->get('SSL_CHECK_BOX_INFORMATION_HEADING'); ?></div>
			<div class="panel-body">
				<?php echo $osC_Language->get('SSL_CHECK_BOX_INFORMATION'); ?>
			</div>
		</div>
		
		<?php echo $osC_Language->get('SSL_CHECK_TEXT_INFORMATION'); ?>
		
	</div>
	
	<div class="text-right">
		<?php echo HTML::button($osC_Language->get('IMAGE_BUTTON_CONTINUE'), 'glyphicon glyphicon-chevron-right', OSCOM::link('login.php'), null, null, 'btn-success'); ?>
	</div>
</div>

<?php
	require('includes/template_bottom.php');
	require('includes/application_bottom.php');
?>
