<?php

namespace alkurn\cms\models\search;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use alkurn\cms\models\CmsField;

/**
 * CmsFieldSearch represents the model behind the search form about `alkurn\cms\models\CmsField`.
 */
class CmsFieldSearch extends CmsField
{
    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['field_id', 'category_id', 'order_by', 'status'], 'integer'],
            [['section', 'field', 'name', 'type'], 'safe'],
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
        $query = CmsField::find();

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
            'field_id' => $this->field_id,
            'category_id' => $this->category_id,
            'order_by' => $this->order_by,
            'status' => $this->status,
        ]);

        $query->andFilterWhere(['like', 'section', $this->section])
            ->andFilterWhere(['like', 'field', $this->field])
            ->andFilterWhere(['like', 'name', $this->name])
            ->andFilterWhere(['like', 'type', $this->type]);

        return $dataProvider;
    }
}
