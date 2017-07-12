<?php

namespace alkurn\cms\models;

use Yii;

/**
 * This is the model class for table "cms_menu".
 *
 * @property integer $menu_id
 * @property string $name
 * @property integer $parent_id
 * @property string $route
 * @property integer $order
 * @property string $data
 *
 * @property CmsMenuPath[] $cmsMenuPaths
 * @property CmsMenuPath[] $cmsMenuPaths0
 * @property CmsMenu[] $parents
 * @property CmsMenu[] $menus
 */
class CmsMenu extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'cms_menu';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['name'], 'required'],
            [['parent_id', 'order'], 'integer'],
            [['data'], 'string'],
            [['name', 'route'], 'string', 'max' => 255],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'menu_id' => 'Menu ID',
            'name' => 'Name',
            'parent_id' => 'Parent ID',
            'route' => 'Route',
            'order' => 'Order',
            'data' => 'Data',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCmsMenuPaths()
    {
        return $this->hasMany(CmsMenuPath::className(), ['menu_id' => 'menu_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCmsMenuPaths0()
    {
        return $this->hasMany(CmsMenuPath::className(), ['parent_id' => 'menu_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getParents()
    {
        return $this->hasMany(CmsMenu::className(), ['menu_id' => 'parent_id'])->viaTable('cms_menu_path', ['menu_id' => 'menu_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getMenus()
    {
        return $this->hasMany(CmsMenu::className(), ['menu_id' => 'menu_id'])->viaTable('cms_menu_path', ['parent_id' => 'menu_id']);
    }
}
