<?php

namespace alkurn\cms\models;

use alkurn\user\models\User;
use Yii;

/**
 * This is the model class for table "cms_to_user".
 *
 * @property integer $cms_id
 * @property integer $user_id
 * @property string $status
 * @property integer $dated
 *
 * @property CmsItem $cms
 * @property User $user
 */
class CmsToUser extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'cms_to_user';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['cms_id', 'user_id', 'status', 'dated'], 'required'],
            [['cms_id', 'user_id', 'dated'], 'integer'],
            [['status'], 'string'],
            [['cms_id'], 'exist', 'skipOnError' => true, 'targetClass' => CmsItem::className(), 'targetAttribute' => ['cms_id' => 'id']],
            [['user_id'], 'exist', 'skipOnError' => true, 'targetClass' => User::className(), 'targetAttribute' => ['user_id' => 'id']],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'cms_id' => 'Cms ID',
            'user_id' => 'User ID',
            'status' => 'Status',
            'dated' => 'Dated',
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
    public function getUser()
    {
        return $this->hasOne(User::className(), ['id' => 'user_id']);
    }
}
