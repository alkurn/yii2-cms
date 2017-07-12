<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model alkurn\cms\models\CmsItem */

$this->title = 'Update Page: ' . $model->title;
$this->params['breadcrumbs'][] = ['label' => 'Cms Items', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->title, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="cms-item-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
