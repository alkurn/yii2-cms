<?php

namespace alkurn\cms\models;

use Yii;

/**
 * This is the model class for table "cms_type".
 *
 * @property integer $type_id
 * @property string $type
 *
 * @property CmsItem[] $cmsItems
 */
class CmsType extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'cms_type';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['type'], 'required'],
            [['type'], 'string', 'max' => 100],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'type_id' => 'Type ID',
            'type' => 'Type',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCmsItems()
    {
        return $this->hasMany(CmsItem::className(), ['type_id' => 'type_id']);
    }
}
