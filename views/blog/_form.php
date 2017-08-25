<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use alkurn\ckeditor\CKEditor;
use kartik\file\FileInput;

/* @var $this yii\web\View */
/* @var $model alkurn\cms\models\CmsItem */
/* @var $form yii\widgets\ActiveForm */

$initialImagePreview = [];
if( $model->image ){
    $initialImagePreview[] = Html::img('/uploads/storage/'.$model->image, ['class' => 'file-preview-image', 'height'=>'138', 'width'=>'138']);
}

?>

<div class="cms-item-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'title')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, "image")->widget(FileInput::classname(), [
        'options' => [
            'multiple'  => false,
            'accept'    => 'image/*',
            'class'     => 'option-image'
        ],
        'pluginOptions' => [
            'previewFileType'   => 'image',
            'showCaption'       => false,
            'showUpload'        => false,
            'showRemove'        => false,
            'browseClass'       => 'btn btn-default btn-sm',
            'browseLabel'       => ' Pick image',
            'browseIcon'        => '<i class="glyphicon glyphicon-picture"></i>',
            'removeClass'       => 'btn btn-danger btn-sm',
            'removeLabel'       => ' Delete',
            'removeIcon'        => '<i class="fa fa-trash"></i>',
            'previewSettings'   => [  'image' => ['width' => '138px', 'height' => 'auto'] ],
            'initialPreview' => $initialImagePreview,
            'layoutTemplates' => ['footer' => '']
        ]
    ]);?>


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
