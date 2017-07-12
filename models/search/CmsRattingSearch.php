<?php

namespace alkurn\cms\models\search;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use alkurn\cms\models\CmsRatting;

/**
 * CmsRattingSearch represents the model behind the search form about `alkurn\cms\models\CmsRatting`.
 */
class CmsRattingSearch extends CmsRatting
{
    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['cms_id'], 'integer'],
            [['ratting', 'created_at'], 'safe'],
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
        $query = CmsRatting::find();

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
            'cms_id' => $this->cms_id,
            'created_at' => $this->created_at,
        ]);

        $query->andFilterWhere(['like', 'ratting', $this->ratting]);

        return $dataProvider;
    }
}
