<?php

namespace alkurn\cms\models;

use Yii;

/**
 * This is the model class for table "cms_category_path".
 *
 * @property integer $category_id
 * @property integer $parent_id
 * @property integer $level
 *
 * @property CmsCategory $category
 * @property CmsCategory $parent
 */
class CmsCategoryPath extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'cms_category_path';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['category_id', 'parent_id', 'level'], 'required'],
            [['category_id', 'parent_id', 'level'], 'integer'],
            [['category_id'], 'exist', 'skipOnError' => true, 'targetClass' => CmsCategory::className(), 'targetAttribute' => ['category_id' => 'category_id']],
            [['parent_id'], 'exist', 'skipOnError' => true, 'targetClass' => CmsCategory::className(), 'targetAttribute' => ['parent_id' => 'category_id']],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'category_id' => 'Category ID',
            'parent_id' => 'Parent ID',
            'level' => 'Level',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCategory()
    {
        return $this->hasOne(CmsCategory::className(), ['category_id' => 'category_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getParent()
    {
        return $this->hasOne(CmsCategory::className(), ['category_id' => 'parent_id']);
    }
}
