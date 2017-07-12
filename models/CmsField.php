<?php

namespace alkurn\cms\models;

use Yii;

/**
 * This is the model class for table "cms_field".
 *
 * @property integer $field_id
 * @property integer $category_id
 * @property string $section
 * @property string $field
 * @property string $name
 * @property string $type
 * @property integer $order_by
 * @property integer $status
 *
 * @property CmsCategory $category
 * @property CmsFieldOption[] $cmsFieldOptions
 * @property CmsFieldValue[] $cmsFieldValues
 */
class CmsField extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'cms_field';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['category_id', 'order_by', 'status'], 'integer'],
            [['section', 'type'], 'string'],
            [['field', 'name'], 'string', 'max' => 100],
            [['category_id'], 'exist', 'skipOnError' => true, 'targetClass' => CmsCategory::className(), 'targetAttribute' => ['category_id' => 'category_id']],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'field_id' => 'Field ID',
            'category_id' => 'Category ID',
            'section' => 'Section',
            'field' => 'Field',
            'name' => 'Name',
            'type' => 'Type',
            'order_by' => 'Order By',
            'status' => 'Status',
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
    public function getCmsFieldOptions()
    {
        return $this->hasMany(CmsFieldOption::className(), ['field_id' => 'field_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCmsFieldValues()
    {
        return $this->hasMany(CmsFieldValue::className(), ['field_id' => 'field_id']);
    }
}
