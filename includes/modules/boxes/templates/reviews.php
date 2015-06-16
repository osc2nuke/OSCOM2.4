<?php
	use OSC\OM\OSCOM;
?>
<div class="panel panel-default">
	<div class="panel-heading"><a href="<?php echo OSCOM::link('reviews.php'); ?>"><?php echo $osC_Language->get('MODULE_BOXES_REVIEWS_BOX_TITLE'); ?></a></div>
	<div class="panel-body"><?php echo $reviews_box_contents; ?></div>
</div>

