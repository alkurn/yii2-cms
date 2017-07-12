<?php

namespace alkurn\cms\models;

use Yii;

/**
 * This is the model class for table "cms_gallary".
 *
 * @property integer $id
 * @property integer $cms_id
 * @property string $title
 * @property integer $type
 *
 * @property CmsItem $cms
 * @property CmsGallaryItem[] $cmsGallaryItems
 */
class CmsGallary extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'cms_gallary';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['cms_id', 'title'], 'required'],
            [['cms_id', 'type'], 'integer'],
            [['title'], 'string', 'max' => 250],
            [['cms_id'], 'exist', 'skipOnError' => true, 'targetClass' => CmsItem::className(), 'targetAttribute' => ['cms_id' => 'id']],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'cms_id' => 'Cms ID',
            'title' => 'Title',
            'type' => 'Type',
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
    public function getCmsGallaryItems()
    {
        return $this->hasMany(CmsGallaryItem::className(), ['gallery_id' => 'id']);
    }
}
