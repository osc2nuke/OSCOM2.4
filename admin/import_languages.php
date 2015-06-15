<?php
	/*
		$Id$
		
		osCommerce, Open Source E-Commerce Solutions
		http://www.oscommerce.com
		
		Copyright (c) 2014 osCommerce
		
		Released under the GNU General Public License
	*/
	
	require('includes/application_top.php');
	
	$action = (isset($_GET['action']) ? $_GET['action'] : '');
	/*
		if (tep_not_null($action)) {
		if ($action == 'reset') {
		tep_reset_cache_block($_GET['block']);
		}
		
		tep_redirect(tep_href_link(FILENAME_CACHE));
		}
		
		// check if the cache directory exists
		if (is_dir(DIR_FS_CACHE)) {
		if (!tep_is_writable(DIR_FS_CACHE)) $messageStack->add(ERROR_CACHE_DIRECTORY_NOT_WRITEABLE, 'error');
		} else {
		$messageStack->add(ERROR_CACHE_DIRECTORY_DOES_NOT_EXIST, 'error');
		}
	*/
	require(DIR_WS_INCLUDES . 'template_top.php');
?>

<table border="0" width="100%" cellspacing="0" cellpadding="2">
	<tr>
        <td><table border="0" width="100%" cellspacing="0" cellpadding="0">
			<tr>
				<td class="pageHeading"><?php echo HEADING_TITLE; ?></td>
				<td class="pageHeading" align="right"><?php echo tep_draw_separator('pixel_trans.gif', HEADING_IMAGE_WIDTH, HEADING_IMAGE_HEIGHT); ?></td>
			</tr>
		</table></td>
	</tr>
	<tr>
        <td><table border="0" width="100%" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top"><table border="0" width="100%" cellspacing="0" cellpadding="2">
					<?php
						//header('Content-Type: text/plain');
						
						$defines = array();
						$state = 0;
						$key = '';
						$value = '';
						
						$path_parts = pathinfo('../includes/languages/english/modules/social_bookmarks/sb_twitter_button.php');
						$file = file_get_contents($path_parts['dirname'] .'/' . $path_parts['basename']);

						$tokens = token_get_all($file);
						$token = reset($tokens);
						while ($token) {
							if (is_array($token)) {
								if ($token[0] == T_WHITESPACE || $token[0] == T_COMMENT || $token[0] == T_DOC_COMMENT) {
									// do nothing
									} else if ($token[0] == T_STRING && strtolower($token[1]) == 'define') {
									$state = 1;
									} else if ($state == 2 && is_constant($token[0])) {
									$key = $token[1];
									$state = 3;
									} else if ($state == 4 && is_constant($token[0])) {
									$value = $token[1];
									$state = 5;
								}
								} else {
								$symbol = trim($token);
								if ($symbol == '(' && $state == 1) {
									$state = 2;
									} else if ($symbol == ',' && $state == 3) {
									$state = 4;
									} else if ($symbol == ')' && $state == 5) {
									$defines[strip($key)] = strip($value);
									$state = 0;
								}
							}
							$token = next($tokens);
						}
						echo '<pre>';						
						foreach ($defines as $k => $v) {
						
							$insert_sql_data = array('languages_id' => 1,
													 'content_group' => 'modules-social_bookmarks',
													 'definition_key' => $k,
													 'definition_value' => $v);


							tep_db_perform('osc_languages_definitions', $insert_sql_data);	
							echo "'$k' => '$v'\n";
						}
						echo '</pre>';
						
						function is_constant($token) {
							return $token == T_CONSTANT_ENCAPSED_STRING || $token == T_STRING ||
							$token == T_LNUMBER || $token == T_DNUMBER;
						}
						
						function strip($value) {
							return preg_replace('!^([\'"])(.*)\1$!', '$2', $value);
						}	
						
						
						
					?>
					
					
				</table></td>
			</tr>
		</table></td>
	</tr>
</table>

<?php
	require(DIR_WS_INCLUDES . 'template_bottom.php');
	require(DIR_WS_INCLUDES . 'application_bottom.php');
?>
