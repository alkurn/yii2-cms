<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use alkurn\ckeditor\CKEditor;
/* @var $this yii\web\View */
/* @var $model alkurn\cms\models\CmsItem */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="cms-item-form">

    <?php $form = ActiveForm::begin(); ?>


    <?= $form->field($model, 'title')->textInput(['maxlength' => true]) ?>
    <?= $form->field($model, 'content')->widget(CKEditor::className(), [
        'options' => ['rows' => 6], 'preset' => 'basic'
    ])?>
    <?= $form->field($model, 'meta_title')->textarea(['rows' => 6]) ?>
    <?= $form->field($model, 'meta_description')->textarea(['rows' => 6]) ?>
    <?= $form->field($model, 'meta_keywords')->textarea(['rows' => 6]) ?>

    <div class="form-group">
        <?= Html::submitButton($model->isNewRecord ? 'Create' : 'Update', ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
