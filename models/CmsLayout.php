<?php

namespace alkurn\cms\models;

use Yii;

/**
 * This is the model class for table "cms_layout".
 *
 * @property integer $layout_id
 * @property string $name
 *
 * @property CmsItem[] $cmsItems
 */
class CmsLayout extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'cms_layout';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['name'], 'required'],
            [['name'], 'string', 'max' => 250],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'layout_id' => 'Layout ID',
            'name' => 'Name',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCmsItems()
    {
        return $this->hasMany(CmsItem::className(), ['layout_id' => 'layout_id']);
    }
}
