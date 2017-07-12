<?php

namespace alkurn\cms\models\search;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use alkurn\cms\models\CmsGallary;

/**
 * CmsGallarySearch represents the model behind the search form about `alkurn\cms\models\CmsGallary`.
 */
class CmsGallarySearch extends CmsGallary
{
    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['id', 'cms_id', 'type'], 'integer'],
            [['title'], 'safe'],
        ];
    }

    /**
     * @inheritdoc
     */
    public function scenarios()
    {
        // bypass scenarios() implementation in the parent class
        return Model::scenarios();
    }

    /**
     * Creates data provider instance with search query applied
     *
     * @param array $params
     *
     * @return ActiveDataProvider
     */
    public function search($params)
    {
        $query = CmsGallary::find();

        // add conditions that should always apply here

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
        ]);

        $this->load($params);

        if (!$this->validate()) {
            // uncomment the following line if you do not want to return any records when validation fails
            // $query->where('0=1');
            return $dataProvider;
        }

        // grid filtering conditions
        $query->andFilterWhere([
            'id' => $this->id,
            'cms_id' => $this->cms_id,
            'type' => $this->type,
        ]);

        $query->andFilterWhere(['like', 'title', $this->title]);

        return $dataProvider;
    }
}
