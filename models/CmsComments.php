<?php

namespace alkurn\cms\models;

use alkurn\user\models\User;
use Yii;

/**
 * This is the model class for table "cms_comments".
 *
 * @property integer $comment_id
 * @property integer $review_id
 * @property integer $user_id
 * @property string $email
 * @property string $comment
 * @property integer $created_at
 * @property string $update_at
 *
 * @property CmsReviews $review
 * @property User $user
 */
class CmsComments extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'cms_comments';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['review_id', 'comment', 'created_at'], 'required'],
            [['review_id', 'user_id', 'created_at'], 'integer'],
            [['comment'], 'string'],
            [['update_at'], 'safe'],
            [['email'], 'string', 'max' => 64],
            [['review_id'], 'exist', 'skipOnError' => true, 'targetClass' => CmsReviews::className(), 'targetAttribute' => ['review_id' => 'review_id']],
            [['user_id'], 'exist', 'skipOnError' => true, 'targetClass' => User::className(), 'targetAttribute' => ['user_id' => 'id']],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'comment_id' => 'Comment ID',
            'review_id' => 'Review ID',
            'user_id' => 'User ID',
            'email' => 'Email',
            'comment' => 'Comment',
            'created_at' => 'Created At',
            'update_at' => 'Update At',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getReview()
    {
        return $this->hasOne(CmsReviews::className(), ['review_id' => 'review_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getUser()
    {
        return $this->hasOne(User::className(), ['id' => 'user_id']);
    }
}
