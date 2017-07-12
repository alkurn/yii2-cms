<?php

use yii\helpers\Html;
use yii\widgets\DetailView;
use alkurn\thumbnail\ThumbnailImage;

/* @var $this yii\web\View */
/* @var $model alkurn\cms\models\CmsItem */

$this->title = $model->title;
$this->params['breadcrumbs'][] = ['label' => 'Blogs', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="cms-item-view">

    <h1><?= Html::encode($this->title) ?></h1>

    <div class="blog-list">
        <div class="blog-img"> <?= ThumbnailImage::thumbnailImg($model->image, 500, 500) ?> </div>
        <div class="content">
            <?= $model->content; ?>
        </div>
        <div class="clearfix"></div>
    </div>


    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            'id',
            'user_id',
            'parent_id',
            'layout_id',
            'type_id',
            'slug',
            'external_url:url',
            'title',
            'content:ntext',
            'image',
            'media',
            'location',
            'latitude',
            'longitude',
            'restricted',
            'status',
            'meta_title:ntext',
            'meta_description:ntext',
            'meta_keywords:ntext',
            'modified_date',
            'created_at',
        ],
    ]) ?>

</div>
