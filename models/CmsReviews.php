<?php

namespace alkurn\cms\models;

use alkurn\user\models\User;
use Yii;

/**
 * This is the model class for table "cms_reviews".
 *
 * @property integer $review_id
 * @property integer $cms_id
 * @property integer $user_id
 * @property string $email
 * @property string $review
 * @property integer $status
 * @property integer $created_at
 * @property string $update_at
 *
 * @property CmsComments[] $cmsComments
 * @property CmsItem $cms
 * @property User $user
 */
class CmsReviews extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'cms_reviews';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['cms_id', 'review', 'created_at'], 'required'],
            [['cms_id', 'user_id', 'status', 'created_at'], 'integer'],
            [['review'], 'string'],
            [['update_at'], 'safe'],
            [['email'], 'string', 'max' => 64],
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
            'review_id' => 'Review ID',
            'cms_id' => 'Cms ID',
            'user_id' => 'User ID',
            'email' => 'Email',
            'review' => 'Review',
            'status' => 'Status',
            'created_at' => 'Created At',
            'update_at' => 'Update At',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCmsComments()
    {
        return $this->hasMany(CmsComments::className(), ['review_id' => 'review_id']);
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
