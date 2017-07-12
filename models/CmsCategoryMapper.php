<?php

namespace alkurn\cms\models;

use Yii;

/**
 * This is the model class for table "cms_category_mapper".
 *
 * @property integer $cms_id
 * @property integer $category_id
 *
 * @property CmsItem $cms
 * @property CmsCategory $category
 */
class CmsCategoryMapper extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'cms_category_mapper';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['cms_id', 'category_id'], 'required'],
            [['cms_id', 'category_id'], 'integer'],
            [['cms_id'], 'exist', 'skipOnError' => true, 'targetClass' => CmsItem::className(), 'targetAttribute' => ['cms_id' => 'id']],
            [['category_id'], 'exist', 'skipOnError' => true, 'targetClass' => CmsCategory::className(), 'targetAttribute' => ['category_id' => 'category_id']],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'cms_id' => 'Cms ID',
            'category_id' => 'Category ID',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCms()
    {
        return $this->hasOne(CmsItem::className(), ['id' => 'cms_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCategory()
    {
        return $this->hasOne(CmsCategory::className(), ['category_id' => 'category_id']);
    }
}
