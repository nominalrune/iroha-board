<?php
/**
 * iroha Board Project
 *
 * @author        Kotaro Miura
 * @copyright     2015-2016 iroha Soft, Inc. (http://irohasoft.jp)
 * @link          http://irohaboard.irohasoft.jp
 * @license       http://www.gnu.org/licenses/gpl-3.0.en.html GPL License
 */

class DATABASE_CONFIG {

	public $default = array(
		'datasource' => 'Database/Mysql',
		'persistent' => true,
		'host' => 'mysql',
		'login' => 'root',
		'password' => 'root',
		'database' => 'irohaboard',
		'prefix' => 'ib_',
		'encoding' => 'utf8'
	);
}
