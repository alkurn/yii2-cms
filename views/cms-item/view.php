<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model alkurn\cms\models\CmsItem */

$this->title = $model->title;
$this->params['breadcrumbs'][] = ['label' => 'Pages', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="cms-item-view">

    <h1><?= Html::encode($this->title) ?></h1>

    <p>
        <?= Html::a('Update', ['update', 'id' => $model->id], ['class' => 'btn btn-primary']) ?>
        <?= Html::a('Delete', ['delete', 'id' => $model->id], [
            'class' => 'btn btn-danger',
            'data' => [
                'confirm' => 'Are you sure you want to delete this item?',
                'method' => 'post',
            ],
        ]) ?>
    </p>

    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            'id',
            'user_id',
            'parent_id',
            'layout_id',
            'slug',
            'external_url:url',
            'title',
            'content:html',
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
