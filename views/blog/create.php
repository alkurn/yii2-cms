<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model alkurn\cms\models\CmsItem */

$this->title = 'Create Blog';
$this->params['breadcrumbs'][] = ['label' => 'Cms Items', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="cms-item-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
