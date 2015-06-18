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
	
	$breadcrumb->add($osC_Language->get('CREATE_ACCOUNT_SUCCESS_NAVBAR_TITLE_1'));
	$breadcrumb->add($osC_Language->get('CREATE_ACCOUNT_SUCCESS_NAVBAR_TITLE_2'));
	
	if (sizeof($_SESSION['navigation']->snapshot) > 0) {
		$origin_href = OSCOM::link($_SESSION['navigation']->snapshot['page'], tep_array_to_string($_SESSION['navigation']->snapshot['get'], array(session_name())), $_SESSION['navigation']->snapshot['mode']);
		$_SESSION['navigation']->clear_snapshot();
		} else {
		$origin_href = OSCOM::link('index.php');
	}
	
	require('includes/template_top.php');
?>

<div class="page-header">
	<h1><?php echo $osC_Language->get('CREATE_ACCOUNT_SUCCESS_HEADING_TITLE'); ?></h1>
</div>

<div class="contentContainer">
	<div class="contentText">
		<div class="alert alert-success">
			<?php echo $osC_Language->get('CREATE_ACCOUNT_SUCCESS_TEXT_ACCOUNT_CREATED'); ?>
		</div>
	</div>
	
	<div><?php echo HTML::button($osC_Language->get('IMAGE_BUTTON_CONTINUE'), 'glyphicon glyphicon-chevron-right', $origin_href, null, null, 'btn-success btn-block'); ?></div>
</div>

<?php
	require('includes/template_bottom.php');
	require('includes/application_bottom.php');
?>
