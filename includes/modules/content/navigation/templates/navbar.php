<?php
use OSC\OM\HTML;
use OSC\OM\OSCOM;
?>
<nav class="navbar navbar-inverse navbar-no-corners navbar-no-margin" role="navigation">
  <div class="<?php echo BOOTSTRAP_CONTAINER; ?>">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-navbar-collapse-core-nav">
        <span class="sr-only"><?php echo $osC_Language->get('MODULE_CONTENT_NAVBAR_TOGGLE_NAV'); ?></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
    </div>
    <div class="collapse navbar-collapse" id="bs-navbar-collapse-core-nav">
      <ul class="nav navbar-nav">
        <?php echo '<li><a class="store-brand" href="' . OSCOM::link('index.php') . '">' . $osC_Language->get('MODULE_CONTENT_NAVBAR_HOME') . '</a></li>'; ?>
        <?php echo '<li><a href="' . OSCOM::link('products_new.php') . '">' . $osC_Language->get('MODULE_CONTENT_NAVBAR_WHATS_NEW') . '</a></li>'; ?>
        <?php echo '<li><a href="' . OSCOM::link('specials.php') . '">' . $osC_Language->get('MODULE_CONTENT_NAVBAR_SPECIALS') . '</a></li>'; ?>
        <?php echo '<li><a href="' . OSCOM::link('reviews.php') . '">' . $osC_Language->get('MODULE_CONTENT_NAVBAR_REVIEWS') . '</a></li>'; ?>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <?php
        if (substr(basename($PHP_SELF), 0, 8) != 'checkout') {
          ?>
          <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#"><?php echo $osC_Language->get('MODULE_CONTENT_NAVBAR_SITE_SETTINGS'); ?></a>
            <ul class="dropdown-menu">
              <li class="text-center text-muted bg-primary"><?php echo sprintf($osC_Language->get('MODULE_CONTENT_NAVBAR_USER_LOCALIZATION'), $_SESSION['currency']); ?></li>
              <?php
              // languages
              if (!isset($lng) || (isset($lng) && !is_object($lng))) {
               include(DIR_WS_CLASSES . 'language.php');
                $lng = new language;
              }
              if (count($lng->catalog_languages) > 1) {
                echo '<li class="divider"></li>';
                foreach($lng->catalog_languages as $key => $value) {
                  echo '<li><a href="' . OSCOM::link(basename($PHP_SELF), tep_get_all_get_params(array('language', 'currency')) . 'language=' . $key, $request_type) . '">' . HTML::image(DIR_WS_LANGUAGES .  $value['directory'] . '/images/' . $value['image'], $value['name'], null, null, null, false) . ' ' . $value['name'] . '</a></li>';
                }
              }
              // currencies
              if (isset($currencies) && is_object($currencies) && (count($currencies->currencies) > 1)) {
                echo '<li class="divider"></li>';
                reset($currencies->currencies);
                $currencies_array = array();
                foreach($currencies->currencies as $key => $value) {
                  echo '<li><a href="' . OSCOM::link(basename($PHP_SELF), tep_get_all_get_params(array('language', 'currency')) . 'currency=' . $key, $request_type) . '">' . $value['title'] . '</a></li>';
                }
              }
              ?>
            </ul>
          </li>
          <?php
        }
        ?>
        <li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#"><?php echo (isset($_SESSION['customer_id'])) ? sprintf($osC_Language->get('MODULE_CONTENT_NAVBAR_ACCOUNT_LOGGED_IN'), $_SESSION['customer_first_name']) : $osC_Language->get('MODULE_CONTENT_NAVBAR_ACCOUNT_LOGGED_OUT'); ?></a>
          <ul class="dropdown-menu">
            <?php
            if (isset($_SESSION['customer_id'])) {
              echo '<li><a href="' . OSCOM::link('logoff.php', '', 'SSL') . '">' . $osC_Language->get('MODULE_CONTENT_NAVBAR_ACCOUNT_LOGOFF') . '</a>';
            }
            else {
               echo '<li><a href="' . OSCOM::link('login.php', '', 'SSL') . '">' . $osC_Language->get('MODULE_CONTENT_NAVBAR_ACCOUNT_LOGIN') . '</a>';
               echo '<li><a href="' . OSCOM::link('create_account.php', '', 'SSL') . '">' . $osC_Language->get('MODULE_CONTENT_NAVBAR_ACCOUNT_REGISTER') . '</a>';
            }
            ?>
            <li class="divider"></li>
            <li><?php echo '<a href="' . OSCOM::link('account.php', '', 'SSL') . '">' . $osC_Language->get('MODULE_CONTENT_NAVBAR_ACCOUNT') . '</a>'; ?></li>
            <li><?php echo '<a href="' . OSCOM::link('account_history.php', '', 'SSL') . '">' . $osC_Language->get('MODULE_CONTENT_NAVBAR_ACCOUNT_HISTORY') . '</a>'; ?></li>
            <li><?php echo '<a href="' . OSCOM::link('address_book.php', '', 'SSL') . '">' . $osC_Language->get('MODULE_CONTENT_NAVBAR_ACCOUNT_ADDRESS_BOOK') . '</a>'; ?></li>
            <li><?php echo '<a href="' . OSCOM::link('account_password.php', '', 'SSL') . '">' . $osC_Language->get('MODULE_CONTENT_NAVBAR_ACCOUNT_PASSWORD') . '</a>'; ?></li>
          </ul>
        </li>
        <?php
        if ($_SESSION['cart']->count_contents() > 0) {
          ?>
          <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#"><?php echo sprintf($osC_Language->get('MODULE_CONTENT_NAVBAR_CART_CONTENTS'), $_SESSION['cart']->count_contents()); ?></a>
            <ul class="dropdown-menu">
              <li><?php echo '<a href="' . OSCOM::link('shopping_cart.php') . '">' . sprintf($osC_Language->get('MODULE_CONTENT_NAVBAR_CART_HAS_CONTENTS'), $_SESSION['cart']->count_contents(), $currencies->format($_SESSION['cart']->show_total())) . '</a>'; ?></li>
              <li class="divider"></li>
              <li><?php echo '<a href="' . OSCOM::link('shopping_cart.php') . '">' . $osC_Language->get('MODULE_CONTENT_NAVBAR_CART_VIEW_CART') . '</a>'; ?></li>
            </ul>
          </li>
          <?php
          echo '<li><a href="' . OSCOM::link('checkout_shipping.php', '', 'SSL') . '">' . $osC_Language->get('MODULE_CONTENT_NAVBAR_CART_CHECKOUT') . '</a></li>';
        }
        else {
          echo '<li class="nav navbar-text">' . $osC_Language->get('MODULE_CONTENT_NAVBAR_CART_NO_CONTENTS') . '</li>';
        }
        ?>
      </ul>
    </div>
  </div>
</nav>


