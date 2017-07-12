<?php

namespace alkurn\cms\models\search;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use alkurn\cms\models\CmsBlockMapper;

/**
 * CmsBlockMapperSearch represents the model behind the search form about `alkurn\cms\models\CmsBlockMapper`.
 */
class CmsBlockMapperSearch extends CmsBlockMapper
{
    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['block_id', 'cms_id', 'order_by'], 'integer'],
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
        $query = CmsBlockMapper::find();

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
            'block_id' => $this->block_id,
            'cms_id' => $this->cms_id,
            'order_by' => $this->order_by,
        ]);

        return $dataProvider;
    }
}
