<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model alkurn\cms\models\search\BlogSearch */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="cms-item-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
    ]); ?>
    <?= $form->field($model, 'title') ?>

    <?php // echo $form->field($model, 'id') ?>

    <?php // echo $form->field($model, 'user_id') ?>

    <?php // echo $form->field($model, 'parent_id') ?>

    <?php // echo $form->field($model, 'layout_id') ?>

    <?php // echo $form->field($model, 'type_id') ?>

    <?php // echo $form->field($model, 'slug') ?>

    <?php // echo $form->field($model, 'external_url') ?>

    <?php // echo $form->field($model, 'title') ?>

    <?php // echo $form->field($model, 'content') ?>

    <?php // echo $form->field($model, 'image') ?>

    <?php // echo $form->field($model, 'media') ?>

    <?php // echo $form->field($model, 'location') ?>

    <?php // echo $form->field($model, 'latitude') ?>

    <?php // echo $form->field($model, 'longitude') ?>

    <?php // echo $form->field($model, 'restricted') ?>

    <?php // echo $form->field($model, 'status') ?>

    <?php // echo $form->field($model, 'meta_title') ?>

    <?php // echo $form->field($model, 'meta_description') ?>

    <?php // echo $form->field($model, 'meta_keywords') ?>

    <?php // echo $form->field($model, 'modified_date') ?>

    <?php // echo $form->field($model, 'created_at') ?>

    <div class="form-group">
        <?= Html::submitButton('Search', ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton('Reset', ['class' => 'btn btn-default']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
