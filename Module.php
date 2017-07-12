<?php

namespace alkurn\cms;
use backend\modules\auth\components\Configs;
/**
 * item module definition class
 */
class Module extends \yii\base\Module
{
    /**
     * @inheritdoc
     */
    public $defaultRoute = 'cms-item';

    /**
     * @var array
     * @see [[items]]
     */
    private $_menus = [];

    /**
     * @var array
     * @see [[items]]
     */
    private $_moduleItems = [
        'cms-item'        => 'Pages',
        'blog'        => 'Blog',
    ];

    /**
     * @var array
     * @see [[items]]
     */
    private $_normalizeMenus;

    /**
     * Nav bar items
     * @var array
     */
    public $navbar;

    /**
     * @var string Main layout using for module. Default to layout of parent module.
     * Its used when `layout` set to 'left-menu', 'right-menu' or 'top-menu'.
     */
    public $mainLayout = '';

    /**
     * @inheritdoc
     */

    public function init()
    {
        parent::init();
    }

    /**
     * Get avalible menu.
     * @return array
     */
    public function getMenus()
    {

        if ($this->_normalizeMenus === null) {
            $mid = '/' . $this->getUniqueId() . '/';

            // resolve ads menus
            $this->_normalizeMenus = [];
            //$config = components\Configs::instance();
            $config = Configs::instance();
            foreach ($this->_moduleItems as $id => $lable) {
                if ($id !== 'menu' || ($config->db !== null && $config->db->schema->getTableSchema($config->menuTable) !== null)) {
                    $this->_normalizeMenus[$id] = ['label' => $lable, 'url' => [$mid . $id]];
                }
            }
            foreach (array_keys($this->controllerMap) as $id) {
                $this->_normalizeMenus[$id] = ['label' => Inflector::humanize($id), 'url' => [$mid . $id]];
            }

            // user configure menus
            foreach ($this->_menus as $id => $value) {
                if (empty($value)) {
                    unset($this->_normalizeMenus[$id]);
                } else {
                    if (is_string($value)) {
                        $value = [
                            'label' => $value,
                        ];
                    }
                    $this->_normalizeMenus[$id] = isset($this->_normalizeMenus[$id]) ? array_merge($this->_normalizeMenus[$id], $value) : $value;
                    if (!isset($this->_normalizeMenus[$id]['url'])) {
                        $this->_normalizeMenus[$id]['url'] = [$mid . $id];
                    }
                }
            }
        }
        return $this->_normalizeMenus;
    }

    /**
     * Set or add avalible menu.
     * @param array $menus
     */
    public function setMenus($menus)
    {
        $this->_menus = array_merge($this->_menus, $menus);
        $this->_normalizeMenus = null;
    }
}
