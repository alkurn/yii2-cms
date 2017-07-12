<?php

namespace alkurn\cms\models;

use Yii;

/**
 * This is the model class for table "cms_menu_path".
 *
 * @property integer $menu_id
 * @property integer $parent_id
 * @property integer $level
 *
 * @property CmsMenu $menu
 * @property CmsMenu $parent
 */
class CmsMenuPath extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'cms_menu_path';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['menu_id', 'parent_id', 'level'], 'required'],
            [['menu_id', 'parent_id', 'level'], 'integer'],
            [['menu_id'], 'exist', 'skipOnError' => true, 'targetClass' => CmsMenu::className(), 'targetAttribute' => ['menu_id' => 'menu_id']],
            [['parent_id'], 'exist', 'skipOnError' => true, 'targetClass' => CmsMenu::className(), 'targetAttribute' => ['parent_id' => 'menu_id']],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'menu_id' => 'Menu ID',
            'parent_id' => 'Parent ID',
            'level' => 'Level',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getMenu()
    {
        return $this->hasOne(CmsMenu::className(), ['menu_id' => 'menu_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getParent()
    {
        return $this->hasOne(CmsMenu::className(), ['menu_id' => 'parent_id']);
    }
}
