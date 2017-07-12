<?php

use yii\helpers\Html;
use yii\widgets\ListView;

/* @var $this yii\web\View */
/* @var $searchModel backend\modules\cms\models\search\BlogSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Blogs';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="cms-item-index">

    <h1><?= Html::encode($this->title) ?></h1>
    <?php echo $this->render('partial/_search', ['model' => $searchModel]); ?>

    <section class="blog-listing">
        <div class="row">
            <div class="col-sm-12">
                <?= ListView::widget([
                    'dataProvider' => $dataProvider,
                    'itemView' => 'partial/_item',
                    'itemOptions' => ['tag' => false,],
                    'layout' => '<div id="pagination-wrap" class="hidden">{sorter}\n{pager}</div>{items}',
                ]); ?>
            </div>
        </div>
    </section>
</div>
