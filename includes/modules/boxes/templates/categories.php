<?php
	$OSCOM_CategoryTree->setCategoryPath($cPath, '<strong>', '</strong>');
	$OSCOM_CategoryTree->setSpacerString('&nbsp;&nbsp;', 1);
	
	$OSCOM_CategoryTree->setParentGroupString('<ul class="nav nav-pills nav-stacked">', '</ul>', true);
?>
<div class="panel panel-default">
	<div class="panel-heading"><?php echo $osC_Language->get('MODULE_BOXES_CATEGORIES_BOX_TITLE'); ?></div>
	<?php echo $OSCOM_CategoryTree->getTree(); ?>
</div>
