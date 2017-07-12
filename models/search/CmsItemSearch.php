<?php

namespace alkurn\cms\models\search;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use alkurn\cms\models\CmsItem;

/**
 * CmsItemSearch represents the model behind the search form about `alkurn\cms\models\CmsItem`.
 */
class CmsItemSearch extends CmsItem
{
    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['id', 'user_id', 'parent_id', 'layout_id','type_id', 'restricted', 'status', 'created_at'], 'integer'],
            [['slug', 'external_url', 'title', 'content', 'image', 'media', 'location', 'meta_title', 'meta_description', 'meta_keywords', 'modified_date'], 'safe'],
            [['latitude', 'longitude'], 'number'],
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
        $query = CmsItem::find();

        // add conditions that should always apply here

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
        ]);

        $this->load($params);

        /*if (!$this->validate()) {
            // uncomment the following line if you do not want to return any records when validation fails
            // $query->where('0=1');
            return $dataProvider;
        }*/

        $query->andFilterWhere(['type_id' => self::TYPE_PAGE,]);

        // grid filtering conditions
        $query->andFilterWhere([
            'id' => $this->id,
            'user_id' => $this->user_id,
            'parent_id' => $this->parent_id,
            'layout_id' => $this->layout_id,
            'latitude' => $this->latitude,
            'longitude' => $this->longitude,
            'restricted' => $this->restricted,
            'status' => $this->status,
            'modified_date' => $this->modified_date,
            'created_at' => $this->created_at,
        ]);

        $query->andFilterWhere(['like', 'slug', $this->slug])
            ->andFilterWhere(['like', 'external_url', $this->external_url])
            ->andFilterWhere(['like', 'title', $this->title])
            ->andFilterWhere(['like', 'content', $this->content])
            ->andFilterWhere(['like', 'image', $this->image])
            ->andFilterWhere(['like', 'media', $this->media])
            ->andFilterWhere(['like', 'location', $this->location])
            ->andFilterWhere(['like', 'meta_title', $this->meta_title])
            ->andFilterWhere(['like', 'meta_description', $this->meta_description])
            ->andFilterWhere(['like', 'meta_keywords', $this->meta_keywords]);

        return $dataProvider;
    }
}
