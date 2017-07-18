<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel alkurn\cms\models\search\CmsItemSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Pages';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="cms-item-index">

    <h1><?= Html::encode($this->title) ?></h1>
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <p>
        <?= Html::a('Create Page', ['create'], ['class' => 'btn btn-success']) ?>
    </p>
    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            //'id',
            //'user_id',
            //'parent_id',
            //'layout_id',
            'title',
            //'image',
            'slug',
            // 'external_url:url',
            // 'title',
            // 'content:ntext',
            // 'image',
            // 'media',
            // 'location',
            // 'latitude',
            // 'longitude',
            // 'restricted',
            [
                    'attribute' =>'status',
                    'value' => function($model){ return ($model->status == 1) ? 'Active' : 'De-Active'; }
            ],
            // 'meta_title:ntext',
            // 'meta_description:ntext',
            // 'meta_keywords:ntext',
            // 'modified_date',
             'created_at:date',

            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]); ?>
</div>
