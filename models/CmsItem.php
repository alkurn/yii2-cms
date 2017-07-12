<?php

namespace alkurn\cms\models;

use Yii;
use yii\behaviors\SluggableBehavior;

/**
 * This is the model class for table "cms_item".
 *
 * @property integer $id
 * @property integer $user_id
 * @property integer $parent_id
 * @property integer $layout_id
 * @property integer $type_id
 * @property string $slug
 * @property string $external_url
 * @property string $title
 * @property string $content
 * @property string $image
 * @property string $media
 * @property string $location
 * @property string $latitude
 * @property string $longitude
 * @property integer $restricted
 * @property integer $status
 * @property string $meta_title
 * @property string $meta_description
 * @property string $meta_keywords
 * @property string $modified_date
 * @property integer $created_at
 *
 * @property CmsBlockMapper[] $cmsBlockMappers
 * @property CmsBlock[] $blocks
 * @property CmsCategoryMapper[] $cmsCategoryMappers
 * @property CmsCategory[] $categories
 * @property CmsFieldValue[] $cmsFieldValues
 * @property CmsGallary[] $cmsGallaries
 * @property CmsItem $parent
 * @property CmsItem[] $cmsItems
 * @property CmsLayout $layout
 * @property CmsType $type
 * @property CmsMedia[] $cmsMedia
 * @property CmsPath[] $cmsPaths
 * @property CmsPath[] $cmsPaths0
 * @property CmsItem[] $paths
 * @property CmsItem[] $cms
 * @property CmsRatting $cmsRatting
 * @property CmsRelation[] $cmsRelations
 * @property CmsKeyword[] $keywords
 * @property CmsReviews[] $cmsReviews
 * @property CmsToUser[] $cmsToUsers
 * @property CmsWidgetMapper[] $cmsWidgetMappers
 * @property CmsWidget[] $widgets
 */

class CmsItem extends \yii\db\ActiveRecord
{
    const TYPE_PAGE = 1;
    const TYPE_BLOG = 2;
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'cms_item';
    }

    public function behaviors()
    {
        return [
            [
                'class' => SluggableBehavior::className(),
                'attribute' => 'title',
                'immutable' => true,
                'ensureUnique' => true,
                'slugAttribute' => 'slug',
            ],
        ];
    }

    public function beforeValidate()
    {
        if (parent::beforeValidate()) {

            $this->user_id = Yii::$app->user->id;
            $this->parent_id = null;
            $this->layout_id = 1;
            $this->restricted = 0;
            $this->status = 1;
            $this->created_at = time();
            return true;
        }

        return false;
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['user_id', 'parent_id', 'layout_id',  'type_id', 'restricted', 'status', 'created_at'], 'integer'],
            [['title','content', 'slug', 'created_at'], 'required'],
            [['content', 'meta_title', 'meta_description', 'meta_keywords'], 'string'],
            [['latitude', 'longitude'], 'number'],
            [['modified_date'], 'safe'],
            [['slug'], 'string', 'max' => 100],
            [['external_url', 'title'], 'string', 'max' => 255],
            [['image', 'media', 'location'], 'string', 'max' => 200],
            [['slug'], 'unique'],
            [['parent_id'], 'exist', 'skipOnError' => true, 'targetClass' => CmsItem::className(), 'targetAttribute' => ['parent_id' => 'id']],
            [['layout_id'], 'exist', 'skipOnError' => true, 'targetClass' => CmsLayout::className(), 'targetAttribute' => ['layout_id' => 'layout_id']],
            [['type_id'], 'exist', 'skipOnError' => true, 'targetClass' => CmsType::className(), 'targetAttribute' => ['type_id' => 'type_id']],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'user_id' => 'User ID',
            'parent_id' => 'Parent ID',
            'layout_id' => 'Layout ID',
            'type_id' => 'Type ID',
            'slug' => 'Slug',
            'external_url' => 'External Url',
            'title' => 'Title',
            'content' => 'Content',
            'image' => 'Image',
            'media' => 'Media',
            'location' => 'Location',
            'latitude' => 'Latitude',
            'longitude' => 'Longitude',
            'restricted' => 'Restricted',
            'status' => 'Status',
            'meta_title' => 'Meta Title',
            'meta_description' => 'Meta Description',
            'meta_keywords' => 'Meta Keywords',
            'modified_date' => 'Modified Date',
            'created_at' => 'Created At',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCmsBlockMappers()
    {
        return $this->hasMany(CmsBlockMapper::className(), ['cms_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBlocks()
    {
        return $this->hasMany(CmsBlock::className(), ['block_id' => 'block_id'])->viaTable('cms_block_mapper', ['cms_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCmsCategoryMappers()
    {
        return $this->hasMany(CmsCategoryMapper::className(), ['cms_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCategories()
    {
        return $this->hasMany(CmsCategory::className(), ['category_id' => 'category_id'])->viaTable('cms_category_mapper', ['cms_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCmsFieldValues()
    {
        return $this->hasMany(CmsFieldValue::className(), ['cms_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCmsGallaries()
    {
        return $this->hasMany(CmsGallary::className(), ['cms_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getParent()
    {
        return $this->hasOne(CmsItem::className(), ['id' => 'parent_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCmsItems()
    {
        return $this->hasMany(CmsItem::className(), ['parent_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getLayout()
    {
        return $this->hasOne(CmsLayout::className(), ['layout_id' => 'layout_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getType()
    {
        return $this->hasOne(CmsType::className(), ['type_id' => 'type_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCmsMedia()
    {
        return $this->hasMany(CmsMedia::className(), ['cms_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCmsPaths()
    {
        return $this->hasMany(CmsPath::className(), ['cms_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCmsPaths0()
    {
        return $this->hasMany(CmsPath::className(), ['path_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getPaths()
    {
        return $this->hasMany(CmsItem::className(), ['id' => 'path_id'])->viaTable('cms_path', ['cms_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCms()
    {
        return $this->hasMany(CmsItem::className(), ['id' => 'cms_id'])->viaTable('cms_path', ['path_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCmsRatting()
    {
        return $this->hasOne(CmsRatting::className(), ['cms_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCmsRelations()
    {
        return $this->hasMany(CmsRelation::className(), ['cms_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getKeywords()
    {
        return $this->hasMany(CmsKeyword::className(), ['keyword_id' => 'keyword_id'])->viaTable('cms_relation', ['cms_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCmsReviews()
    {
        return $this->hasMany(CmsReviews::className(), ['cms_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCmsToUsers()
    {
        return $this->hasMany(CmsToUser::className(), ['cms_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCmsWidgetMappers()
    {
        return $this->hasMany(CmsWidgetMapper::className(), ['cms_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getWidgets()
    {
        return $this->hasMany(CmsWidget::className(), ['widget_id' => 'widget_id'])->viaTable('cms_widget_mapper', ['cms_id' => 'id']);
    }
}
