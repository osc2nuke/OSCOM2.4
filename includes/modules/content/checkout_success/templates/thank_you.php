<?php
	use OSC\OM\OSCOM;
?>
<div class="contentText">
	<div class="alert alert-success">
		<?php echo $osC_Language->get('MODULE_CONTENT_CHECKOUT_SUCCESS_TEXT_SUCCESS'); ?>
	</div>
</div>

<div class="contentText">
	<div class="alert alert-info">
		<?php echo sprintf($osC_Language->get('MODULE_CONTENT_CHECKOUT_SUCCESS_TEXT_SEE_ORDERS'), OSCOM::link('account_history.php', '', 'SSL')) . '<br /><br />' . sprintf($osC_Language->get('MODULE_CONTENT_CHECKOUT_SUCCESS_TEXT_CONTACT_STORE_OWNER'), OSCOM::link('contact_us.php')); ?>
	</div>
</div>

<div class="contentText">
	<div class="page-header">
		<h4><?php echo $osC_Language->get('MODULE_CONTENT_CHECKOUT_SUCCESS_TEXT_THANKS_FOR_SHOPPING'); ?></h4>
	</div>
</div>
