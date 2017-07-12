<?php

namespace alkurn\cms\models;

use Yii;

/**
 * This is the model class for table "cms_field_option".
 *
 * @property integer $option_id
 * @property integer $field_id
 * @property string $name
 * @property string $value
 *
 * @property CmsField $field
 */
class CmsFieldOption extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'cms_field_option';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['field_id'], 'integer'],
            [['name', 'value'], 'string', 'max' => 100],
            [['field_id'], 'exist', 'skipOnError' => true, 'targetClass' => CmsField::className(), 'targetAttribute' => ['field_id' => 'field_id']],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'option_id' => 'Option ID',
            'field_id' => 'Field ID',
            'name' => 'Name',
            'value' => 'Value',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getField()
    {
        return $this->hasOne(CmsField::className(), ['field_id' => 'field_id']);
    }
}
