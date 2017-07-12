<?php

namespace alkurn\cms\models;

use Yii;

/**
 * This is the model class for table "cms_gallary_item".
 *
 * @property integer $id
 * @property integer $gallery_id
 * @property string $item
 *
 * @property CmsGallary $gallery
 */
class CmsGallaryItem extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'cms_gallary_item';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['gallery_id', 'item'], 'required'],
            [['gallery_id'], 'integer'],
            [['item'], 'string', 'max' => 250],
            [['gallery_id'], 'exist', 'skipOnError' => true, 'targetClass' => CmsGallary::className(), 'targetAttribute' => ['gallery_id' => 'id']],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'gallery_id' => 'Gallery ID',
            'item' => 'Item',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getGallery()
    {
        return $this->hasOne(CmsGallary::className(), ['id' => 'gallery_id']);
    }
}
