<?php

namespace alkurn\cms\models;

use Yii;

/**
 * This is the model class for table "cms_ratting".
 *
 * @property integer $cms_id
 * @property string $ratting
 * @property string $created_at
 *
 * @property CmsItem $cms
 */
class CmsRatting extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'cms_ratting';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['ratting'], 'required'],
            [['created_at'], 'safe'],
            [['ratting'], 'string', 'max' => 250],
            [['cms_id'], 'exist', 'skipOnError' => true, 'targetClass' => CmsItem::className(), 'targetAttribute' => ['cms_id' => 'id']],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'cms_id' => 'Cms ID',
            'ratting' => 'Ratting',
            'created_at' => 'Created At',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCms()
    {
        return $this->hasOne(CmsItem::className(), ['id' => 'cms_id']);
    }
}
