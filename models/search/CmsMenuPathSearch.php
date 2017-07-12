<?php

namespace alkurn\cms\models\search;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use alkurn\cms\models\CmsMenuPath;

/**
 * CmsMenuPathSearch represents the model behind the search form about `alkurn\cms\models\CmsMenuPath`.
 */
class CmsMenuPathSearch extends CmsMenuPath
{
    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['menu_id', 'parent_id', 'level'], 'integer'],
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
        $query = CmsMenuPath::find();

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
            'menu_id' => $this->menu_id,
            'parent_id' => $this->parent_id,
            'level' => $this->level,
        ]);

        return $dataProvider;
    }
}
