<?php

namespace alkurn\cms\controllers;

use alkurn\cms\models\CmsItem;
use alkurn\cms\models\search\BlogSearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;

/**
 * Default controller for the `cms` module
 */
class DefaultController extends Controller
{

    public function actionPage($slug)
    {
        return $this->render('page/index', [
            'model' => $this->findSlug($slug),
        ]);
    }

    public function findSlug($slug)
    {

        if (($model = CmsItem::find()->where(['slug' => $slug])->one()) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist, try new page');
        }
    }

    /* Blog section */

    /**
     * Lists all CmsItem models.
     * @return mixed
     */
    public function actionBlogs()
    {
        $searchModel = new BlogSearch();
        $dataProvider = $searchModel->search(\Yii::$app->request->queryParams);

        return $this->render('blog/index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single CmsItem model.
     * @param integer $id
     * @return mixed
     */
    public function actionBlog($id)
    {
        return $this->render('blog/view', [
            'model' => $this->findBlog($id),
        ]);
    }

    /**
     * Finds the CmsItem model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return CmsItem the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findBlog($id)
    {
        if (($model = CmsItem::findOne($id)) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }


}
