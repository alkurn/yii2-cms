<?php

namespace alkurn\cms\models\search;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use alkurn\cms\models\CmsPath;

/**
 * CmsPathSearch represents the model behind the search form about `alkurn\cms\models\CmsPath`.
 */
class CmsPathSearch extends CmsPath
{
    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['cms_id', 'path_id', 'level'], 'integer'],
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
        $query = CmsPath::find();

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
            'path_id' => $this->path_id,
            'level' => $this->level,
        ]);

        return $dataProvider;
    }
}
