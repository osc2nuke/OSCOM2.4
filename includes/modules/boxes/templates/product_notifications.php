<?php
	use OSC\OM\OSCOM;
?>
<div class="panel panel-default">
	<div class="panel-heading"><a href="<?php echo OSCOM::link('account_notifications.php', '', 'SSL'); ?>"><?php echo $osC_Language->get('MODULE_BOXES_PRODUCT_NOTIFICATIONS_BOX_TITLE'); ?></a></div>
	<div class="panel-body"><?php echo $notif_contents; ?></div>
</div>
